{
  inputs.hyprland.url = "github:hyprwm/Hyprland";

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.shinishiho = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
