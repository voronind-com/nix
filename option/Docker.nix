{ lib, ... }:
{
  options.module.docker = {
    enable = lib.mkEnableOption "the docker.";
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
