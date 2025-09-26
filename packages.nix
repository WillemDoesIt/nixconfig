{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # MINECRAFT STUFF
    (prismlauncher.override {
      # Add binary required by some mod
      additionalPrograms = [pkgs.ffmpeg];

      # Change Java runtimes available to Prism Launcher
      jdks = [
        graalvm-ce
        zulu8
        zulu17
        zulu
      ];
    })

    # this makes `re` a command that runs the rebuild script
    (writeShellScriptBin "re" ''
      bash /etc/nixos/commands/rebuild.sh "$@"
    '')

    # this makes `texpdf` a command that converts tex files to pdf
    (writeShellScriptBin "texpdf" ''
      bash /etc/nixos/commands/texpdf.sh "$@"
    '')

    # this makes `ccmd` a command that clipboards prev command
    (writeShellScriptBin "ccmd" ''
      bash /etc/nixos/commands/ccmd.sh "$@"
    '')

    ##
    #  TEMP
    #
    ##
    nushell # alternative shell
    dust # wintree for linux
    bat # better `cat`
    gitui
    wiki-tui # wikipedia tui
    nomacs
    gparted
    docker
    docui
    busybox
    pavucontrol
    stockfish
    blueberry
    networkmanager
    cudaPackages.cudatoolkit
    cbonsai
    xdg-user-dirs
    sageWithDoc
    wireshark-qt
    texlive.combined.scheme-full

    cargo
    rustc
    irust # rust dev tool
    cargo-info
    bacon
    sccache
    miniserve
    ladybird

    ##
    #  General
    #
    ##
    btop-cuda
    kitty
    fish # terminal and shell
    ollama
    librechat
    lf # ranger                # terminal file manager
    #alt: nnn           # even simpler
    nemo # gui file manager
    #alt: pcmanfm
    vesktop
    discord
    obs-studio
    firefox
    brave
    librewolf
    sidequest
    ncspot # terminal spotify
    spotify
    audacious # gui music
    #alt: lollypop
    beeper
    element-desktop
    ticktick
    alejandra
    audacity
    transmission_4-qt # torrent engine
    #alt: qbittorrent-nox
    vlc # media viewer
    #alt: mpv

    #parsec-bin           # doesn't host !?
    #xrdp                 # remote desktop
    #lynx                 # terminal based web browser

    ##
    #  File editing
    #
    ##
    gimp
    krita
    davinci-resolve
    obsidian
    blender
    godot_4
    vscode
    neovim
    vim
    ripgrep
    fd
    lazygit
    vimPlugins.rustaceanvim
    #reaper               # audio tool

    ##
    #  Microsoft / Office
    #
    ##
    p3x-onenote # kinda useless, just web shit
    libreoffice
    #alt: freeoffice
    onedrive
    teams-for-linux
    thunderbird # email client
    #alt: protonmail-desktop  # save this for when you make a proton email
    evolution # email client evolution
    evolution-ews # Required for Microsoft Exchange Web Services (EWS)
    gnome-keyring # Manages saved credentials
    seahorse # Optional, GUI for managing stored credentials
    libsoup
    #dnw: bottles-unwrapped            # ways to run microsoft stuff on linux
    wineWowPackages.waylandFull

    ##
    #  Games
    #
    ##
    tetrio-desktop
    lutris
    steam

    ##
    #  Utils
    #
    ##
    git
    man
    tldr
    killall
    expressvpn
    zip
    unzip
    #alt: flameshot
    #dnw: roccat-tools  # for Roccat (brand) keyboard (25.03.04)

    # uselesss terminall stuffs
    neofetch
    pipes
    lolcat
    cowsay
    zsh
    autojump

    ##
    #  Hyprland dependencies and daemons
    #
    ##
    waybar # menu bar
    dunst # notification daemon
    libnotify
    rofi-wayland # program runner
    mpvpaper # live wallpaper (commmand run in hyprland.conf on startup)
    hyprpaper
    hyprshot
    hyprcursor
    wl-clipboard
    playerctl # media control for shortcuts
    #dnw: hyprlock      # lock screen manager
  ];
}
