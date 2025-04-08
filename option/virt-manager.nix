{ lib, config, ... }:
let
  inherit (config.module) purpose;
in
{
  options.module.virtmanager.enable = lib.mkEnableOption "the VM support." // {
    default = purpose.work;
  };
}
