{ config, lib, ... }:
with lib;
let
  cfg = config.module.desktop.dm;
in
{
  options = {
    module.desktop.dm.enable = mkEnableOption "Display Manager.";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = config.setting.keyboard.layouts;
      options = config.setting.keyboard.options;
    };
  };
}
