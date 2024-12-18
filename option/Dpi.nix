{ lib, pkgsMaster, ... }:
{
  options.module.dpi.bypass = {
    enable = lib.mkEnableOption "the Zapret DPI bypass service.";
    package = lib.mkPackageOption pkgsMaster "zapret" { };
    params = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
    whitelist = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
    blacklist = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
    qnum = lib.mkOption {
      default = 200;
      type = lib.types.int;
    };
    configureFirewall = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
    httpSupport = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
    httpMode = lib.mkOption {
      default = "first";
      type = lib.types.enum [
        "first"
        "full"
      ];
    };
    udpSupport = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    udpPorts = lib.mkOption {
      default = [ ];
      type = with lib.types; listOf str;
    };
  };
}
