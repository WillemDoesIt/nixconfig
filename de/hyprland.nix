{
  config,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet -s Hyprland";
        user = "greeter";
      };
    };
  };

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    greetd.gtkgreet
    cage
  ];
}
