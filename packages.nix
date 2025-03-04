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

    # typical apps
    spotify
    ncspot       # terminal spotify
    btop
    alacritty
    ollama
    ranger       # terminal file manager
    nemo         # gui file manager
    pcmanfm
    discord
    vesktop      # discord modifier (didn't seem to work)
    obs-studio
    obsidian
    brave        # browser
    blender
    godot_4
    sqlitestudio
    sidequest
    #lollypop    # mid music player
    audacious    # hopefully better one?
    #parsec-bin  # doesn't host !?
    #xrdp        # remote desktop
    ollama
    #protonmail-desktop   # save this for when you make a proton email
    thunderbird # email client
    beeper
    ticktick
    alejandra 
    audacity
    #lynx # terminal based web browser
    
    # microsoft
    p3x-onenote   # kinda useless, just web shit
    evolution
    onedrive
    teams-for-linux
    #bottles-unwrapped            # ways to run microsoft stuff on linux (doesn't seem to work)
    #wineWowPackages.waylandFull
    


    # email client evolution and it's dependencies
    evolution
    evolution-ews  # Required for Microsoft Exchange Web Services (EWS)
    gnome.gnome-keyring  # Manages saved credentials
    gnome.seahorse  # Optional, GUI for managing stored credentials
    libsoup


    # Games
    tetrio-desktop
    lutris
    steam
    
    # media viewer
    vlc
    mpv

    # utils
    git
    man
    tldr
    killall
    glib      # not sure what this is for
    dconf     # or this...
    expressvpn
    roccat-tools  # for my keyboard
    
    # file editing
    gimp
    krita
    davinci-resolve
    libreoffice
    vscode
    vim
    neovim
    #reaper # audio tool
    
    # uselesss terminall stuffs
    neofetch
    pipes
    cowsay
    
    # torrent engines
    transmission_4-qt
    #qbittorrent-nox
    
    # zip tools
    zip
    unzip
    p7zip-rar
    
    # screenshot tool
    hyprshot
    #flameshot
   

    # maybe rename this daemons for better organization ?

    # hyprland stuff 
    waybar        # menu bar
    dunst         # notification daemon
    libnotify
    rofi-wayland  # program runner
    #hyprpaper
    mpvpaper      # live wallpaper (commmand run in hyprland.conf on startup)
    hyprlock      # lock screen manager
    playerctl     # media control for shortcuts

      
    # rust stuff
    cargo
    
    # cpp stuff
    gcc
    gnumake
    cmake
    clang
    lldb
   
    #sql stuff
    # postgresql # maybe another time...
    sqlite

    # nvchad stuff
    ripgrep
    fd
    lazygit

    # fonts 
    jetbrains-mono # font
    nerdfonts      # this may not work lmao
    corefonts
    vistafonts
  ];
}
