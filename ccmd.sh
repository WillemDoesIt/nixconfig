#!/usr/bin/env fish

function clip
    if test "$XDG_SESSION_TYPE" = "wayland" -a (type -q wl-copy)
        wl-copy
    else if test "$XDG_SESSION_TYPE" = "x11" -a (type -q xclip)
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
    set count (if test (count $argv) -ge 1; echo $argv[1]; else; echo 1; end)
    set with_cmd (contains -- "--with-cmd" $argv)

    if test $with_cmd
        history | tail -n $count | sed 's/^[0-9]* //' | clip
    else
        history | tail -n $count | tail -n1 | sed 's/^[0-9]* //' | clip
    end
end
