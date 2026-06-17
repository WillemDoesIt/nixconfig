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

  environment.systemPackages = with pkgs; [
    hyprland
    wlogout
  ];
}
