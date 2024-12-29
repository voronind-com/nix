# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/KkZFMD3.png";
  sha256 = "sha256-cTNUeamZTjQDx8gGZkU1mj4kKS3FEE0+EDzFb5bsyZE=";
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
