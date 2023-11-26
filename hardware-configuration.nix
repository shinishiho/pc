{ config, lib, pkgs, ... }:

with lib;

{
  
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };
  } // (lib.optionalAttrs (cfg.extraDisk != null) {
    ${cfg.extraDisk.mountPoint} = {
      device = "/dev/disk/by-label/" + cfg.extraDisk.label;
      autoResize = true;
      fsType = "ext4";
    };
  });

  boot.growPartition = true;
  boot.loader.grub.device = "/dev/sda";

  swapDevices = [{
    device = "/var/swap";
    size = 2048;
  }];

  virtualisation.virtualbox.guest.enable = true;

};
