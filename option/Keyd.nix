{ lib, ... }:
{
  options.module.keyd.enable = lib.mkEnableOption "the keyboard remaps.";
}
