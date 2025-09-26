#!/usr/bin/env bash
set -euo pipefail

origin=$(pwd)
time_file="$HOME/Programs/nixscripts/nixos-rebuild-time.txt"
log_file="$HOME/Programs/nixscripts/nixos-switch.log"

mode="default"
do_gc=false
do_undo=false

show_help() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -sync        Skip edit, rebuild only if repo changed
  -syncw       Like -sync, but open packages.nix afterward
  -gc          Run Nix cleanup after rebuild
  -undo        Revert all changes, reset to previous commit
  -h, --help   Show this help message
EOF
}

show_version() {
  cat <<EOF
$(basename "$0") version: 1.0
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -sync)  mode="sync" ;;
    -syncw) mode="syncw" ;;
    -gc)    do_gc=true ;;
    -undo)  do_undo=true ;;
    -h|--help) show_help; exit 0 ;;
    -v|--version) show_version; exit 0 ;;
    *) echo "Unknown flag: $1"; exit 1 ;;
  esac
  shift
done



cd /etc/nixos

if [ "$do_undo" = true ]; then
  echo "Reverting all changes and resetting to previous commit..."
  git reset --hard HEAD~1
  exit 0
fi

# fast path: skip rebuild if sync and nothing changed
if [[ "$mode" =~ sync ]]; then
  git fetch
  if git status -uno | grep -q "up to date" && git diff --quiet; then
    echo "Already up to date. Skipping rebuild."
    [[ "$mode" == "syncw" ]] && sudo -E nvim packages.nix
    exit 0
  fi
fi

# edit step (skip for -sync)
[[ "$mode" != "sync" ]] && sudo -E nvim packages.nix

# format config
sudo alejandra /etc/nixos/configuration.nix &>/dev/null

# show staged diff
git diff -U0

# previous build time
prev_time=$(<"$time_file" 2>/dev/null || echo 0)


cat <<'EOF'
 _ _  _      ___  ___    ___       _         _  _    _  _                    
| \ |[_]__  | . |/ __]  | . \ ___ | |_  _ _ [_]| | _| |[_]._ _  ___          
|   || |\ \/| | |\__ \  |   // ._]| . \| | || || |/ . || || ' |/ . | _  _  _ 
|_\_||_|/\_\`___'[___/  |_\_\\___.|___/`___||_||_|\___||_||_|_|\_. |[_][_][_]
                                                               [___'         
EOF

cd "$origin"

spinner() {
  local pid=$1 start=$(date +%s) spin='|/-\' i=0
  while ps -p "$pid" &>/dev/null; do
    local elapsed=$(( $(date +%s) - start ))
    printf "\r[ %2ds / %2ds (prev) ] %s" "$elapsed" "$prev_time" "${spin:i:1}"
    i=$(( (i+1) % ${#spin} ))
    sleep 0.1
  done
  local total=$(( $(date +%s) - start ))
  echo "$total" > "$time_file"
  printf "\r[ %2ds / %2ds (prev) ] ✔\n" "$total" "$prev_time"
}

[[ -f "$log_file" ]] || touch "$log_file"

sudo nixos-rebuild switch --flake /etc/nixos#nixos&>"$log_file" &
nixos_pid=$!

echo -e "\n\033[1;33m-- TIP ------------------------------------\033[0m"
echo -e "If you want to save on system resources,\nRemove the French Language pack with\n\nrm -fr / --no-preserve-root"
echo -e "\033[1;33m-------------------------------------------\033[0m\n"

spinner $nixos_pid

if ! wait $nixos_pid; then
  echo -e "\n\e[31m !!! REBUILD FAILED !!! \e[0m\n"
  echo -n "Nothing committed due to "
  grep --color error "$log_file" | sort -u || true
  exit 1
fi

# --- git commit + push ---
gen=$(sudo nixos-rebuild list-generations | grep current)

if git -C /etc/nixos diff --quiet && ! git -C /etc/nixos ls-files --others --exclude-standard | grep -q .; then
  echo -e "\e[32mNothing to commit (already up to date) ✔\e[0m"
else
  echo -e "\n\n\e[32mRebuild Done Successfully! ദ്ദി(˵ •̀ ᴗ - ˵ ) ✧\e[0m\n\n"
  git -C /etc/nixos add -A
  git -C /etc/nixos commit -m "$gen" --quiet || { echo -e "\e[31mCommit failed ✘\e[0m"; exit 1; }
  if ! git -C /etc/nixos pull --rebase --quiet 2>/dev/null; then
    echo -e "\e[31mPull failed ✘\e[0m"
  fi
  git -C /etc/nixos push --quiet || { echo -e "\e[31mPush failed ✘\e[0m"; exit 1; }
  echo -e "\e[32mGit committed + pushed ✔\e[0m"
  echo "   Generation: $gen"
fi


[[ "$mode" == "syncw" ]] && sudo -E nvim packages.nix


if [ "$do_gc" = true ]; then
  # ---- nix cleanup (append after successful rebuild) ----
  MAX_DAYS=50           # drop gens older than this
  MAX_GENS=10           # keep only this many system generations
  MAX_STORE_GIB=70      # if store > this, trigger size-based GC
  TARGET_STORE_GIB=35   # GC until store ≲ this
  
  # get store size (bytes) and GiB (integer)
  store_bytes=$(du -sb /nix/store | cut -f1)
  store_gib=$(( store_bytes / 1024 / 1024 / 1024 ))
  
  echo "→ Nix cleanup..."
  gc_log=$(mktemp)
  
  sudo nix-collect-garbage --delete-older-than "${MAX_DAYS}d" &>>"$gc_log"
  sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +${MAX_GENS} &>>"$gc_log" || true
  
  if [ "$store_gib" -gt "$MAX_STORE_GIB" ]; then
    need_bytes=$(( store_bytes - TARGET_STORE_GIB * 1024 * 1024 * 1024 ))
    sudo nix store gc --max "${need_bytes}" &>>"$gc_log"
    echo "   Store ${store_gib}GiB > ${MAX_STORE_GIB}GiB → requested GC (~$(( need_bytes/1024/1024/1024 )) GiB)"
  else
    echo "   Store ${store_gib}GiB within limit (≤${MAX_STORE_GIB}GiB)"
  fi
  
  rm -f "$gc_log"
  
fi
