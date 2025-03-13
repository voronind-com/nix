{ lib, ... }:
{
  options.module.network = {
    setup = {
      wifi = lib.mkEnableOption "setup of the wifi networks.";
      vpn = {
        fsight = lib.mkEnableOption "setup of the fsight vpn.";
        home = lib.mkEnableOption "setup of the home vpn.";
      };
    };
  };
}
