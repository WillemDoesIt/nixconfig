{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # MINECRAFT STUFF
    (prismlauncher.override {
      # Add binary required by some mod
      additionalPrograms = [pkgs.ffmpeg];

      # Change Java runtimes available to Prism Launcher
      jdks = [
        graalvmPackages.graalvm-ce
        zulu8
        zulu17
        zulu
      ];
    })

    # this makes `re` a command that runs the rebuild script
    (writeShellScriptBin "re" ''
      bash /etc/nixos/config/commands/rebuild.sh "$@"
    '')
    fzf

    # this makes `texpdf` a command that converts tex files to pdf
    (writeShellScriptBin "texpdf" ''
      bash /etc/nixos/config/commands/texpdf.sh "$@"
    '')

    # this makes `ccmd` a command that clipboards prev command
    (writeShellScriptBin "ccmd" ''
      bash /etc/nixos/config/commands/ccmd.sh "$@"
    '')

    # this makes `nps` a command that lets you search nixpkgs and install to the shell
    (writeShellScriptBin "nps" ''
      bash /etc/nixos/config/commands/nps.sh "$@"
    '')

    ##
    #  TEMP
    #
    ##
    lmms # music DAW
    gnupg # file and directory encryption
    ncdu # wintree for linux
    bat # better `cat`
    nomacs # image viewer
    gparted
    pavucontrol
    networkmanager
    cudaPackages.cudatoolkit
    xdg-user-dirs
    sageWithDoc
    #docker # needed for winboat
    #freerdp # needed for winboat
    zlib.dev
    expat.dev
    ffmpeg.dev

    ##
    #  General
    #
    ##
    kitty
    fish # terminal and shell
    yazi # terminal file manager
    #alt: nnn, ranger, lf
    nemo # gui file manager
    #alt: pcmanfm
    vesktop
    discord
    obs-studio
    firefox
    librewolf
    spotify
    audacious # gui music
    musikcube
    #alt: lollypop
    beeper
    element-desktop
    alejandra
    audacity
    transmission_4-qt # torrent engine
    #alt: qbittorrent-nox
    #vlc
    (mpv.override {
      scripts = [
        mpvScripts.mpris
        mpvScripts.modernz
      ];
    })

    #parsec-bin           # doesn't host !?
    xrdp # remote desktop
    #lynx                 # terminal based web browser

    ##
    #  File editing
    #
    ##
    gimp
    krita
    obsidian
    blender
    neovim
    vim
    ripgrep
    fd
    lazygit
    handbrake
    #reaper               # audio tool

    ##
    #  Microsoft / Office
    #
    ##
    p3x-onenote # kinda useless, just web shit
    libreoffice
    #alt: freeoffice
    kdePackages.kdenlive
    onedrive
    teams-for-linux
    thunderbird # email client
    #alt: protonmail-desktop  # save this for when you make a proton email
    evolution # email client evolution
    evolution-ews # Required for Microsoft Exchange Web Services (EWS)
    gnome-keyring # Manages saved credentials
    seahorse # Optional, GUI for managing stored credentials
    libsoup_3
    #dnw: bottles-unwrapped            # ways to run microsoft stuff on linux
    wineWowPackages.waylandFull
    #unityhub

    ##
    #  Games
    #
    ##
    tetrio-desktop
    lutris
    steam
    wivrn

    ##
    #  Utils
    #
    ##
    git
    btop-cuda
    man
    tldr
    tmux
    killall
    expressvpn
    zip
    unzip
    gcc
    pkg-config
    miniserve
    openssl.dev
    #busybox
    #alt: flameshot
    #dnw: roccat-tools  # for Roccat (brand) keyboard (25.03.04)

    # uselesss terminall stuffs
    fastfetch
    autojump

    ##
    #  Hyprland dependencies and daemons
    #
    ##
    waybar # menu bar
    dunst # notification daemon
    libnotify
    rofi # program runner
    rofi-bluetooth
    rofi-network-manager
    rofi-power-menu
    brightnessctl
    #mpvpaper # live wallpaper (commmand run in hyprland.conf on startup)
    hyprpaper
    hyprshot
    hyprlock
    hyprcursor
    wl-clipboard
    playerctl # media control for shortcuts
    #dnw: hyprlock      # lock screen manager
  ];
}
