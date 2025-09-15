#!/usr/bin/env bash
# ccmd.sh - copy previous command output

# check which clipboard tool is available
if command -v wl-copy >/dev/null; then
    CLIP="wl-copy"
elif command -v xclip >/dev/null; then
    CLIP="xclip -selection clipboard"
else
    echo "No clipboard tool found (wl-copy or xclip required)"
    exit 1
fi

# fish/bash: get previous command output
# this uses the shell history file to retrieve last command
# run `fc -ln -1` in bash, for fish `history` command
if [ -n "$BASH_VERSION" ]; then
    PREV_CMD=$(fc -ln -1)
elif [ -n "$FISH_VERSION" ]; then
    PREV_CMD=$(history | tail -n 1 | sed 's/^[0-9]* //')
else
    echo "Unsupported shell"
    exit 1
fi

# append the output of the last command
# assumes you run ccmd immediately after a command
# captures stdout of last command
# works if last command output is saved in a temp file
if [ -f /tmp/ccmd_last_output ]; then
    cat /tmp/ccmd_last_output | $CLIP
else
    echo "No previous command output saved. Run commands with:"
    echo 'your_command | tee /tmp/ccmd_last_output'
    exit 1
fi

