{ lib, ... }:
{
  options.module.virtmanager.enable = lib.mkEnableOption "the VM support.";
}
