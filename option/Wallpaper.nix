# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/rkVxIDu.jpeg";
  sha256 = "sha256-/tOlzcICzIwp74g8iAqMPmS0RQC5BzoTmgP4o/JNbq8=";
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
