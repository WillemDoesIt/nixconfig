{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./greeters/ly.nix
  ];

  programs.hyprland.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd.user.services.gnome-keyring = {
    wantedBy = ["graphical-session.target"];
    serviceConfig.ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --foreground --components=secrets,ssh,pkcs11";
  };

  environment.systemPackages = with pkgs; [
    hyprland
    wlogout
  ];
}
