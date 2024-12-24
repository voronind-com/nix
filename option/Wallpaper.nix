# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/FY4ksvg.jpeg";
  sha256 = "sha256-lIhXVXPimgGJ4Z51iM8IzojhxCuM6x8lQljgJtIqYcY=";
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
