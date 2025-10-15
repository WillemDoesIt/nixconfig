{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.displayManager.ly.enable = true;
  environment.systemPackages = [pkgs.ly];
}
