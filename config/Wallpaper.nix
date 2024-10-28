{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/3fJXekt.jpeg";
  sha256 = "sha256-3ZyFZwWuVg4oXZ0zfN2LuPgf7KEFdTS3zWd1FYScOdQ=";
  forceContrastText = false;
in
{
  options = {
    module.wallpaper = {
      forceContrastText = mkOption {
        default = warnIf forceContrastText "Style : Forced text contrast." forceContrastText;
        type = types.bool;
      };
      path = mkOption {
        default = pkgs.fetchurl { inherit url sha256; };
        type = types.path;
      };
    };
  };
}
