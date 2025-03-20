{ lib, ... }:
{
  options.module.powerlimit.thinkpad = {
    enable = lib.mkEnableOption "the powerlimit service";
    onMin = lib.mkOption {
      default = 40;
      type = lib.types.int;
    };
    onMax = lib.mkOption {
      default = 80;
      type = lib.types.int;
    };
    offMin = lib.mkOption {
      default = 90;
      type = lib.types.int;
    };
    offMax = lib.mkOption {
      default = 95;
      type = lib.types.int;
    };
  };
}
