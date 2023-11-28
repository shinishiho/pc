{ config, inputs, ... }:

{

  inputs.hyprland.url = "github:hyprwm/Hyprland";

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.nakxkri = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../configuration.nix
      ];
    };
  };

}
