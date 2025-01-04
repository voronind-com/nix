{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.tablet.enable = lib.mkEnableOption "the support for tables." // {
    default = purpose.creative;
  };
}
