{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.kernel = {
    enable = lib.mkEnableOption "the kernel tweaks." // {
      default = with purpose; desktop || disown || laptop || router || server || work;
    };
    hardening = lib.mkOption {
      default = with purpose; disown || laptop || router || server || work;
      type = lib.types.bool;
    };
    hotspotTtlBypass = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    router = lib.mkOption {
      default = purpose.router;
      type = lib.types.bool;
    };
  };
}
