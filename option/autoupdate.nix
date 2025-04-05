{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.autoupdate = {
    enable = lib.mkEnableOption "the system autoupdates." // {
      default = purpose.disown;
    };
    interval = lib.mkOption {
      default = 60;
      type = lib.types.int;
    };
  };
}
