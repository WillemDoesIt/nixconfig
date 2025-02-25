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
    vesktop     # discord modifier (didn't seem to work)
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
    #xrdp
    ollama

    #protonmail-desktop   # save this for when you make a proton email
    #thunderbird # email client
    beeper
    ticktick
    alejandra
    steam 
    audacity
    lynx # terminal based web browser
    
    # microsoft
    p3x-onenote   # kinda useless, just web shit
    evolution
    onedrive
    
    # media viewer
    vlc
    mpv # not sure if I wanna keep this
    
    # utils
    git
    man
    tldr
    killall
    glib # not sure what this is for
    dconf
    gnome-desktop
    
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
   
    # hyprland stuff 
    waybar        # menu bar
    dunst         # notification daemon
    libnotify
    rofi-wayland  # program runner
    swww          # wallpaper daemon, not sure why I'm not using hyprpaper
    hyprlock      # lock screen manager
    playerctl     # media control for shortcuts
    adwaita-qt    # should do dark theme for gtk
    adwaita-qt6
    breeze-gtk    # more dark theme stuff
    capitaine-cursors
    lxappearance
    gtk3
    gtk2
    gtk_engines
    openjdk

   
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
    jetbrains-mono # font
    nerdfonts      # this may not work lmao
  ];
}
