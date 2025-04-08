{ lib, config, ... }:
let
  inherit (config.module) purpose;
in
{
  options.module.distrobox.enable = lib.mkEnableOption "the distrobox." // {
    default = purpose.work;
  };
}
