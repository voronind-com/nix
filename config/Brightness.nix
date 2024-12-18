{ lib, config, ... }:
let
  cfg = config.module.brightness;
in
{
  config = lib.mkIf cfg.enable { programs.light.enable = true; };
}
