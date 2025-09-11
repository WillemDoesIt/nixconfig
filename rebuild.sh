: '
rebuild
Created by Willem Van Zwol, last edited 2025.09.11

The purpose of this script is to automate and streamline the process of modifying nixos configuration and rebuilding
'

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

# sync modes always pull first
if [[ "$mode" == "sync" || "$mode" == "syncw" ]]; then
  sudo git pull --rebase
fi

# edit step (skip for -sync)
if [[ "$mode" != "sync" ]]; then
  sudo -E nvim packages.nix
fi

sudo alejandra /etc/nixos/configuration.nix &>/dev/null

sudo git diff -U0 configuration.nix || true
sudo git diff -U0 packages.nix || true

# load previous build time
if [[ -f "$time_file" ]]; then
  prev_time=$(cat "$time_file")
else
  prev_time="0"
fi

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
    i=$(( (i + 1) % 4 ))
    sleep 0.1
  done
  local total_time=$(( $(date +%s) - start_time ))
  echo "$total_time" > "$time_file"
  printf "\r[ %2ds / %2ds (prev) ] ✔\n" "$total_time" "$prev_time"
}

# ensure log file exists
[[ -f "$log_file" ]] || { touch "$log_file"; echo "Created log file at $log_file"; }

# run rebuild
sudo nixos-rebuild switch &>$log_file &
nixos_pid=$!

echo -e "\n\033[1;33m-- TIP ------------------------------------\033[0m"
echo -e "If you want to save on system resources,
Remove the French Language pack with

rm -fr / --no-preserve-root"
echo -e "\033[1;33m-------------------------------------------\033[0m\n"

spinner $nixos_pid

if ! wait $nixos_pid; then
  echo -e "\n\n\e[0m
  Aw fuck. You fucked it. Your os is on life support because of your incompitence. You fucking morron.
  \e[0m\n\n"
  echo -n "Nothing committed due to "
  grep --color error "$log_file" | sort -u && false
else
  echo -e "\n\n\e[32mRebuild Done Successfully! ദ്ദി(˵ •̀ ᴗ - ˵ ) ✧\e[0m\n\n"
  echo "Git commit:"
  gen=$(sudo nixos-rebuild list-generations | grep current)
  sudo git -C /etc/nixos commit -am "$gen" && git -C /etc/nixos push
fi

# syncw means edit after a successful rebuild
if [[ "$mode" == "syncw" ]]; then
  sudo -E nvim packages.nix
fi
