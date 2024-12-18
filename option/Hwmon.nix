# Hardware monitor configuration.
{ lib, ... }:
{
  options.module.hwmon = {
    path = lib.mkOption {
      default = "";
      type = lib.types.str;
    };
    file = lib.mkOption {
      default = "";
      type = lib.types.str;
    };
  };
}
