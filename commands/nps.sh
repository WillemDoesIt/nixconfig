#!/usr/bin/env bash
set -euo pipefail

mode="default"

show_help() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -h, --help      Show this help message
  -v, --version   Show the version
EOF
}

show_version() {
  cat <<EOF
$(basename "$0") version: 1.0.0
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) show_help; exit 0 ;;
    -v|--version) show_version; exit 0 ;;
    *) ;;
  esac
  shift
done

query="$1"
if [ -z "$query" ]; then
    echo "Usage: $0 <search-term>"
    exit 1
fi

# Build list of results (cleaned)
results=$(nix search nixpkgs "$query" 2>/dev/null \
    | awk -v q="$query" '
BEGIN {IGNORECASE=1}
{
  match($0, /[^. ]+$/)
  pkg=substr($0, RSTART, RLENGTH)
  if (tolower(pkg) == tolower(q)) {print "0:" $0; next}
  if (tolower($0) ~ tolower(q)) {print "1:" $0}
}
' \
| sort \
| cut -d: -f2- \
| cut -c37- \
| head -n 20)  # let's get 20 for scrolling

# Let user select interactively
chosen=$(echo "$results" | fzf --ansi --height=8 --reverse \
  --bind "tab:toggle+down,shift-tab:toggle+up")

# Install via nix-shell
if [ -n "$chosen" ]; then
    # Extract the first word before any space or parenthesis
    pkg=$(echo "$chosen" | head -n1 | awk '{print $1}' | sed 's/[(].*//')
    nix-shell -p "$pkg"
fi

