{ config, lib, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.live.enable = lib.mkEnableOption "the live modules." // {
    default = purpose.live;
  };
}
