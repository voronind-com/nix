{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.keyd.enable = lib.mkEnableOption "the keyboard remaps." // {
    default = with purpose; desktop || laptop;
  };
}
