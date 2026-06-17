{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;
  environment.systemPackages = [pkgs.ly];
}
