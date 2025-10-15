{
  config,
  pkgs,
  ...
}: {
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';

  environment.variables.GTK_THEME = "Adwaita:dark";

  environment.systemPackages = with pkgs; [
    lxappearance
    gnome-themes-extra
  ];
}
