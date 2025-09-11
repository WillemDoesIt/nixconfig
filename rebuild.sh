#!/usr/bin/env bash
set -e

origin=$(pwd)
time_file="/home/willemvz/Programs/nixscripts/nixos-rebuild-time.txt"
log_file="/home/willemvz/Programs/nixscripts/nixos-switch.log"

mode="default"
case "$1" in
  -sync)  mode="sync" ;;
  -syncw) mode="syncw" ;;
esac

cd /etc/nixos

# fast path: skip rebuild if sync and nothing changed
if [[ "$mode" == "sync" || "$mode" == "syncw" ]]; then
  git fetch
  if git status -uno | grep -q "up to date" && git diff --quiet; then
    echo "Already up to date. Skipping rebuild."
    [[ "$mode" == "syncw" ]] && sudo -E nvim packages.nix
    exit 0
  fi
fi

# edit step (skip for -sync)
if [[ "$mode" != "sync" ]]; then
  sudo -E nvim packages.nix
fi

sudo alejandra /etc/nixos/configuration.nix &>/dev/null

git diff -U0

# load previous build time
prev_time=0
[[ -f "$time_file" ]] && prev_time=$(cat "$time_file")

echo "NixOS Rebuilding..."
cd "$origin"

spinner() {
  local pid=$1
  local start_time=$(date +%s)
  local spinstr='|/-\'
  local i=0
  while ps -p "$pid" > /dev/null; do
    local elapsed=$(( $(date +%s) - start_time ))
    printf "\r[ %2ds / %2ds (prev) ] %s" "$elapsed" "$prev_time" "${spinstr:$i:1}"
    i=$(( (i + 1) % 3 ))
    sleep 0.1
  done
  local total_time=$(( $(date +%s) - start_time ))
  echo "$total_time" > "$time_file"
  printf "\r[ %2ds / %2ds (prev) ] ✔\n" "$total_time" "$prev_time"
}

[[ -f "$log_file" ]] || { touch "$log_file"; echo "Created log file at $log_file"; }

sudo nixos-rebuild switch &>$log_file &
nixos_pid=$!

echo -e "\n\033[1;33m-- TIP ------------------------------------\033[0m"
echo -e "If you want to save on system resources,\nRemove the French Language pack with\n\nrm -fr / --no-preserve-root"
echo -e "\033[1;33m-------------------------------------------\033[0m\n"

spinner $nixos_pid

if ! wait $nixos_pid; then
  echo -e "\n\n\e[0mAw fuck. You fucked it. Your os is on life support because of your incompitence. You fucking morron.\e[0m\n\n"
  echo -n "Nothing committed due to "
  grep --color error "$log_file" | sort -u && false
else
  git pull --rebase --quiet || true
  if ! git diff --quiet; then
    echo -e "\n\n\e[32mRebuild Done Successfully! ദ്ദി(˵ •̀ ᴗ - ˵ ) ✧\e[0m\n\n"
    gen=$(sudo nixos-rebuild list-generations | grep current)

    if git commit -am "$gen" --quiet && git push --quiet; then
      echo -e "\e[32m✔ Git committed + pushed\e[0m"
      echo "   Generation: $gen"
    else
      echo -e "\e[31m✘ Git commit/push failed\e[0m"
    fi
  fi
fi

if [[ "$mode" == "syncw" ]]; then
  sudo -E nvim packages.nix
fi
