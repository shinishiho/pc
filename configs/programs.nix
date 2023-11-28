{ config, pkgs, inputs, ... }:

{
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      # nvidiaPatches = true;
    };

    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        customPkgs = with pkgs; [
          zsh-powerlevel10k
        ];
      };
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

}
