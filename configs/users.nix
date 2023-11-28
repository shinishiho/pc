{ config, pkgs, ... }:

{

  users.users.nakxkri = {
    isNormalUser = true;
    description = "nakxkri";
    extraGroups = [ "networkmanager" "wheel"];
    home = "/home/nakxkri";
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

}
