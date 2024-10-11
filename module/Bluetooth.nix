{ lib, config, ... }:
with lib;
let
  cfg = config.module.desktop.bluetooth;
in
{
  options = {
    module.desktop.bluetooth.enable = mkEnableOption "Bluetooth.";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
