{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./greeters/ly.nix
  ];

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kcalc
    kdePackages.kcolorchooser
  ];
}
