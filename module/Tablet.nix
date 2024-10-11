{ lib, config, ... }:
with lib;
let
  cfg = config.module.tablet;
in
{
  options = {
    module.tablet.enable = mkEnableOption "Support for tables.";
  };

  config = mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;
    systemd.user.services.opentabletdriver.wantedBy = [ "default.target" ];
  };
}
