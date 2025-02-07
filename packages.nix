{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        # MINECRAFT STUFF
        (prismlauncher.override {
            # Add binary required by some mod
            additionalPrograms = [ffmpeg];

            # Change Java runtimes available to Prism Launcher
            jdks = [
                graalvm-ce
                zulu8
                zulu17
                zulu
            ];
        })

        thunderbird
        spotify
        vlc
        btop
        alacritty
        vim
        neovim
        git
        discord
        vencord # discord modifier
        obs-studio
        obsidian
        vscode
        brave
        gimp
        davinci-resolve
        steam
        libreoffice
        beeper
        ticktick
        alejandra
        mpv # not sure if I wanna keep this
        
        # uselesss terminall stuffs
        neofetch
        pipes
        cowsay


        audacity
        ollama
        man
        tldr 
        transmission_4-qt # torrent
        krita
        ranger # terminal file manager
        reaper # audio like thing
        zip # this might be important lmao
        unzip # AND THIS BWAHAHHAHA
        p7zip-rar
        # flameshot # screenshot
        hyprshot

        # hyprland stuff 
        waybar        # menu bar
        dunst         # notification daemon
        libnotify
        rofi-wayland  # program runner
        swww          # wallpaper daemon

        # microsoft
        p3x-onenote
        evolution
        onedrive

        # rust stuff
        cargo

        # cpp stuff
        gcc
        gnumake
        cmake
        clang
        lldb

        # nvchad stuff
        ripgrep
        fd
        lazygit

        jetbrains-mono
    ];
}
