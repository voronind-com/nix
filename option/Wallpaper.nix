# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/6fJxpYe.png";
  sha256 = "sha256-c4pXpPSoIL4CVBLezEYNHVWtioVtgkg2w6bWsWZw+nc=";
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
