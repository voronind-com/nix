{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.autoupdate.enable = lib.mkEnableOption "the system auto-updates." // {
    default = purpose.disown;
  };
}
