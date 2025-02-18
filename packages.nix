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
    btop
    alacritty
    ollama
    ranger       # terminal file manager
    nemo         # gui file manager
    pcmanfm
    discord
    #vencord     # discord modifier (didn't seem to work)
    obs-studio
    obsidian
    brave        # browser
    blender
    godot_4

    #protonmail-desktop   # save this for when you make a proton email
    #thunderbird # email client
    beeper
    ticktick
    alejandra
    steam
    audacity
    
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
    jetbrains-mono # font
    nerdfonts      # this may not work lmao
  ];
}
