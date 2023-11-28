{ config, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.timeout = 0;
    loader.efi.canTouchEfiVariables = true;
    kernelParams = [
      "quiet"
      "loglevel=3"
    ];
  };
}
