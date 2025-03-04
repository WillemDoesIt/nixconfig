{ config, pkgs, ... }: {
  # This may be home-manager nix, If so consider this user instructions:
  # Add this text manually to the `~/.config/gtk-3.0/settings.ini`
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Adwaita-dark;
  '';

  environment.variables = {
    #SAL_USE_VCLPLUGIN = "gtk3";
    #GTK_THEME = "Adwaita-dark";
    #QT_QPA_PLATFORMTHEME = "gtk";
    
    #QT_QPA_PLATFORMTHEME = "qt5ct";
    #QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.systemPackages = with pkgs; [
    #adwaita-qt
    gnome.gnome-themes-extra
    #adwaita-qt6
    #breeze-gtk
    #capitaine-cursors
    lxappearance
    #gtk3
    #gtk2
    #gtk_engines
    #openjdk  
    
    #kvantum 
    #qt5ct
    #qt6ct
  ];
}
