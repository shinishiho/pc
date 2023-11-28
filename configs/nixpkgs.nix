{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    sandbox = true;
    max-jobs = "auto";
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8WtkuGc="
    ];
  };

}
