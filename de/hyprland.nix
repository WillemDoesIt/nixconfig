{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;

  services.displayManager.ly.enable = true;

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    ly
  ];
}
