{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.powersave = {
    enable = lib.mkEnableOption "the powersave";
    laptop = lib.mkOption {
      default = purpose.laptop;
      type = lib.types.bool;
    };
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
