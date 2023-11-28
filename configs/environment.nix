{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      efibootmgr
      neovim
      git
      kitty
      wget
      waybar
      swww
      neofetch
      dolphin
      networkmanagerapplet
      bluez
      blueman
      dunst
      rofi-wayland
      wlogout
      hyprpicker
      slurp
      swappy
      cliphist
      parallel
      jq
      polkit
      xdg-desktop-portal-hyprland
      imagemagick
      brightnessctl
      pavucontrol
      pamixer
      themechanger
      qt5ct
      ark
      pokemon-colorscripts-mac
    ];
  
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };
}
