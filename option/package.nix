{ lib, config, ... }:
let
  cfg = config.module.package;
  purpose = config.module.purpose;
in
{
  options.module.package = {
    all = lib.mkEnableOption "All apps.";
    core = lib.mkEnableOption "Core apps." // {
      default = true;
    };
    common = lib.mkEnableOption "Common Apps." // {
      default = cfg.all || (with purpose; desktop || laptop || parents);
    };
    creative = lib.mkEnableOption "Creative Apps." // {
      default = cfg.all || purpose.creative;
    };
    desktop = lib.mkEnableOption "Desktop Apps." // {
      default = cfg.all || (with purpose; desktop || laptop);
    };
    dev = lib.mkEnableOption "Dev Apps." // {
      default = cfg.all || purpose.work;
    };
    gaming = lib.mkEnableOption "Gaming Apps." // {
      default = cfg.all || purpose.gaming;
    };
    extra = lib.mkEnableOption "Extra Apps." // {
      default = cfg.all;
    };
  };
}
