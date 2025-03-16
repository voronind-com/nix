# Configuration that enables bluetooth support.
{ config, lib, ... }:
let
  cfg = config.module.bluetooth;
in
{
  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
