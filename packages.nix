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
        neofetch
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


        # hyprland stuff
        kitty 
        waybar
        dunst
        libnotify
        rofi-wayland

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
