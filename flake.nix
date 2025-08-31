{
  description = "My sys config in flake form for reproducability";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./packages.nix
	./de/hyprland.nix # alt: ./de/sway.nix
        ./nvidia.nix
        ./dark-mode.nix
      ];
    };
  };
}
