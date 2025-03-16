# Enable brightness controls.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.brightness;
in
{
  config = lib.mkIf cfg.enable {
    programs.light.enable = true;
    environment.systemPackages = with pkgs; [ light ];
  };
}
