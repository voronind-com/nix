{ lib, ... }:
{
  options.module.tablet.enable = lib.mkEnableOption "the support for tables.";
}
