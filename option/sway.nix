{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.sway = {
    enable = lib.mkEnableOption "the Sway WM." // {
      default = with purpose; desktop || laptop;
    };
    extraConfig = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
  };
}
