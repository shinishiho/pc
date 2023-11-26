{ config, pkgs, ... }:

{
  # imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];
  imports =
  [ ./hardware-configuration.nix
    ./nixpkgs-configurations.nix
    ./user-configurations.nix
    ./system-configurations/
    ./services/
  ];  
 
 # Set your system's host name.
  networking.hostName = "shinishiho"; 

  # Specify your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";
 
  # Configure the Nix package manager.
  nix.settings = {
    sandbox = true;
    max-jobs = "auto";
  };

  # Enable the KDE Desktop Environment.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # nvidiaPatches = true;
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      customPkgs = with pkgs; [
        zsh-powerlevel10k
      ];
    };
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
    # nvidia.modesetting.enable = true;
  };

  # Define a user account.
  users.users.nakxkri = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable `sudo` for the user.
    home = "/home/nakxkri";
    shell = pkgs.zsh;
  };

  # Global package installation
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    waybar
    swww
  ];

  # System-wide configuration changes
  system.stateVersion = "23.10"; # Set this to your NixOS release version.
}

