{ config, pkgs, ... }: {
  # This may be home-manager nix, If so consider this user instructions:
  # Add this text manually to the `~/.config/gtk-3.0/settings.ini`
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Adwaita-dark;
  '';

  ##
  # As you can tell a significant portion of this nix file is commented out
  # this is just because I'm nervous my darkmode will break and I will need these things
  # they are all stuff chatgpt or other sources have told me were needed for darkmode
  # but as of right now (2025.03.04) it's working fine as is.
  ##

  /*
  environment.variables = {
    SAL_USE_VCLPLUGIN = "gtk3";
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "gtk";
    
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };
  */

  environment.systemPackages = with pkgs; [
    lxappearance
    gnome.gnome-themes-extra
    
    /*
      adwaita-qt adwaita-qt6 breeze-gtk capitaine-cursors 
      gtk3 gtk2 gtk_engines openjdk kvantum qt5ct qt6ct 
    */
  ];
}
