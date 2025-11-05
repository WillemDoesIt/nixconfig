{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./greeters/ly.nix
  ];

  programs.hyprland.enable = true;
  environment.systemPackages = [pkgs.hyprland];
}
