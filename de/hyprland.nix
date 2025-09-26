/*
* Origin: https://nixos.wiki/wiki/Hyprland
*/
{pkgs, ...}: {
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;
  };
  # ...
}
