{ lib, ... }:
{
  options.module.network = {
    setup = {
      wifi = lib.mkEnableOption "setup of the wifi networks.";
    };
  };
}
