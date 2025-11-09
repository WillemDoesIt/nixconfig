{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./greeters/ly.nix
  ];

  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  environment.systemPackages = with pkgs; [
    xfce.xfce4-terminal
    xfce.thunar
    xfce.mousepad
  ];
}
