{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.distrobox.enable = lib.mkEnableOption "the distrobox." // {
    default = purpose.work;
  };
}
