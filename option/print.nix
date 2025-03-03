{ lib, ... }:
{
  options.module.print.enable = lib.mkEnableOption "the support for printers.";
}
