{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/UpyYtT3.jpeg";
  sha256 = "1dilvn5ls34d5855d1h6k12x9mbdhawd91dl9z5v91ndpbjhip5r";
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
