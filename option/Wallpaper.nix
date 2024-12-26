# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/03KK4WG.jpeg";
  sha256 = "sha256-lCaYGl+Y1iLtslDqAu/HTqpyWgSOnR+bMI0fKSwjW6w=";
  forceContrastText = false;
in
{
  options.module.wallpaper = {
    forceContrastText = lib.mkOption {
      default = lib.warnIf forceContrastText "Wallpaper: Forced text contrast." forceContrastText;
      type = lib.types.bool;
    };
    path = lib.mkOption {
      default = pkgs.fetchurl { inherit url sha256; };
      type = lib.types.path;
    };
  };
}
