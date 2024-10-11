{ lib, config, ... }:
with lib;
let
  cfg = config.module.desktop.brightness;
in
{
  options = {
    module.desktop.brightness.enable = mkEnableOption "Brightness.";
  };

  config = mkIf cfg.enable {
    programs.light.enable = true;
  };
}
