{ lib, ... }:
{
  options.module.powersave = {
    enable = lib.mkEnableOption "the powersave";
    cpu.boost = {
      disableCmd = lib.mkOption {
        default = null;
        type = lib.types.str;
      };
      enableCmd = lib.mkOption {
        default = null;
        type = lib.types.str;
      };
      controlFile = lib.mkOption {
        default = null;
        type = lib.types.str;
      };
    };
  };
}
