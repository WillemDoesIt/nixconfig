{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./greeters/cosmic.nix
  ];

  programs.hyprland.enable = true;
  environment.systemPackages = [pkgs.hyprland];
}
