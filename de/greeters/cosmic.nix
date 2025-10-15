{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;

  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-greeter
  ];
}
