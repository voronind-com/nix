{ lib, ... }:
{
  options.module.polkit.enable = lib.mkEnableOption "the polkit.";
}
