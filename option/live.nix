{ config, lib, ... }:
let
  inherit (config.module) purpose;
in
{
  options.module.live.enable = lib.mkEnableOption "the live modules." // {
    default = purpose.live;
  };
}
