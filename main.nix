{config, ...}: {
  imports = [
    ./configuration.nix
    ./packages.nix
    ./de/hyprland.nix # <-- add as many DE's as you want
    #     alt includes: ./de/sway.nix
    ./de/kde.nix
    ./nvidia.nix
    ./dark-mode.nix
  ];
}
