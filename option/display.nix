# Screen configuration.
{ lib, ... }:
{
  options.module.display = {
    dpiAware = lib.mkOption {
      default = false;
      type = lib.types.bool;
    };
    primary = lib.mkOption {
      default = "*";
      type = lib.types.str;
    };
    logo = lib.mkOption {  # 󰈈󰫢󱝂󱡄󰳊󰋑
      default = ""; # TODO: Check if they fixed ->  or 󱄅 
      type = lib.types.str;
    };
    rotate = lib.mkOption {
      default = { };
      type =
        with lib.types;
        attrsOf (enum [
          0
          90
          180
          270
        ]);
    };
  };
}
