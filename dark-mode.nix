{ config, pkgs, ... }: {
  # Enable dark mode for GTK applications
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
    gtk-theme-name=Adwaita-dark;
  '';

  environment.variables = {
    #SAL_USE_VCLPLUGIN = "gtk3";
    #GTK_THEME = "Adwaita-dark";
    #QT_QPA_PLATFORMTHEME = "gtk";
  };

  environment.systemPackages = with pkgs; [
    #adwaita-qt
    #gnome.gnome-themes-extra
    #adwaita-qt6
    #breeze-gtk
    #capitaine-cursors
    #lxappearance
    #gtk3
    #gtk2
    #gtk_engines
    #openjdk  
  ];
}
