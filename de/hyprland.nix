{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "chili";
    settings = {
      Wayland = {EnableHiDPI = true;};
      X11 = {ServerArguments = "-nolisten tcp -dpi 200";};
    };
  };

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    sddm-chili-theme
  ];
}
