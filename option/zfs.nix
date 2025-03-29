{ lib, ... }:
{
  options.module.zfs = {
    pools = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
    scrub = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
    notify = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };
}
