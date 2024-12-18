{ lib, ... }:
{
  options.module.kernel = {
    enable = lib.mkEnableOption "the kernel tweaks.";
    hardening = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    hotspotTtlBypass = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    latest = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };
}
