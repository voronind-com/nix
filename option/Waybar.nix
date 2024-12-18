{ lib, ... }:
{
  options.module.waybar.enable = lib.mkEnableOption "the Waybar.";
}
