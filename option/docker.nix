{ lib, config, ... }:
let
  inherit (config.module) purpose;
in
{
  options.module.docker = {
    enable = lib.mkEnableOption "the docker." // {
      default = purpose.work;
    };
    rootless = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    autostart = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
  };
}
