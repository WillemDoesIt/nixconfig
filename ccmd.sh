#!/usr/bin/env fish

function clip
    if test "$XDG_SESSION_TYPE" = "wayland"
        wl-copy
    else if test "$XDG_SESSION_TYPE" = "x11"
        xclip -selection clipboard
    else if type -q wl-copy
        wl-copy
    else if type -q xclip
        xclip -selection clipboard
    else if type -q xsel
        xsel --clipboard --input
    else
        echo "No clipboard tool found" >&2
        return 1
    end
end

function copyhist
    set count (or $argv[1] 1)
    set with_cmd (contains -- "--with-cmd" $argv)
    if test $with_cmd
        history | head -n $count | clip
    else
        history | head -n $count | tail -n1 | clip
    end
end

