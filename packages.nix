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


    ##
    #  TEMP
    #
    ##
    xfce.mousepad
    nushell         # alternative shell
    sccache
    eza             # better `ls`
    dust            # wintree for linux
    bat             # better `cat`
    gitui
    porsmo          # pomodoro
    wiki-tui        # wikipedia tui
    nomacs
    gparted
    
    irust           # rust dev tool
    cargo-info 
    bacon
    sccache

    ##
    #  General
    #
    ##
    btop
    alacritty
    ollama
    ranger                # terminal file manager
      #alt: nnn           # even simpler
    nemo                  # gui file manager
      #alt: pcmanfm
    vesktop  
      discord
    obs-studio
    brave
    sidequest
    ncspot                # terminal spotify
      spotify
    audacious             # gui music
      #alt: lollypop
    beeper
    element-desktop
    ticktick
    alejandra 
    audacity 
    transmission_4-qt     # torrent engine
      #alt: qbittorrent-nox
    ollama
    vlc                   # media viewer
      #alt: mpv

    #parsec-bin           # doesn't host !?
    #xrdp                 # remote desktop
    #lynx                 # terminal based web browser
    #parsec-bin           # doesn't host !?
    #xrdp                 # remote desktop

    
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
    sqlitestudio
    vscode
    neovim
      vim
      ripgrep
      fd
      lazygit
    #reaper               # audio tool


    ##
    #  Microsoft / Office
    #
    ##
    p3x-onenote                 # kinda useless, just web shit
    libreoffice   
      #alt: freeoffice
    onedrive
    teams-for-linux
    thunderbird                 # email client 
      #alt: protonmail-desktop  # save this for when you make a proton email
    evolution                   # email client evolution
      evolution-ews             # Required for Microsoft Exchange Web Services (EWS)
      gnome.gnome-keyring       # Manages saved credentials
      gnome.seahorse            # Optional, GUI for managing stored credentials
      libsoup
    #dnw: bottles-unwrapped            # ways to run microsoft stuff on linux
    #dnw: wineWowPackages.waylandFull


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
    glib                # not sure what this is for
    dconf               # or this...
    expressvpn
    zip
    unzip
    p7zip-rar
    hyprshot            # screenshot tool
      #alt: flameshot
    #dnw: roccat-tools  # for Roccat (brand) keyboard (25.03.04)


    # uselesss terminall stuffs
    neofetch
    pipes
    cowsay
   

    ##
    #  Hyprland dependencies and daemons
    #
    ##
    waybar        # menu bar
    dunst         # notification daemon
      libnotify
    rofi-wayland  # program runner
    mpvpaper      # live wallpaper (commmand run in hyprland.conf on startup)
      #alt: hyprpaper
    playerctl     # media control for shortcuts
    #dnw: hyprlock      # lock screen manager 


    ##
    #  Programming Languages
    #  Given how flakes handel things I typically keep all this commented out :P
    ##
    #cargo
    #gcc
    #  gnumake
    #  cmake
    #  clang
    #  lldb
    #sqlite
      #alt: postgresql


    ##
    #  Fonts 
    #
    ##
    jetbrains-mono # font
    nerdfonts      # this may not work lmao
    corefonts
    vistafonts
  ];
}
