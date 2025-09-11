{ config, pkgs, ... }: {

  # This may be home-manager nix, If so consider this user instructions:
  # Add this text manually to the `~/.config/gtk-3.0/settings.ini`
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-application-prefer-dark-theme=1
  '';

  environment.systemPackages = with pkgs; [
    lxappearance
    gnome-themes-extra
  ];
}
