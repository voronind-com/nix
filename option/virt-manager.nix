{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.virtmanager.enable = lib.mkEnableOption "the VM support." // {
    default = purpose.work;
  };
}
