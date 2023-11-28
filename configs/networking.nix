{ config, ... }:

{
  networking = {
    hostName = "shinishiho";
    networkmanager.enable = true;
  };
}
