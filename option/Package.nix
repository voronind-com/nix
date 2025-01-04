{ lib, config, ... }:
let
  purpose = config.module.purpose;
in
{
  options.module.package = {
    core = lib.mkEnableOption "Core apps." // {
      default = true;
    };
    common = lib.mkEnableOption "Common Apps." // {
      default = with purpose; desktop || laptop;
    };
    creative = lib.mkEnableOption "Creative Apps." // {
      default = purpose.creative;
    };
    desktop = lib.mkEnableOption "Desktop Apps." // {
      default = with purpose; desktop || laptop;
    };
    dev = lib.mkEnableOption "Dev Apps." // {
      default = purpose.work;
    };
    gaming = lib.mkEnableOption "Gaming Apps." // {
      default = purpose.gaming;
    };
    extra = lib.mkEnableOption "Extra Apps.";
  };
}
