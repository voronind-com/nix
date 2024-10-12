{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/MAebnX3.jpeg";
  sha256 = "12nvw4srfm7yqazc88c4nz25bl9vfp0jls2hhfqfycajdakhbg1x";
  forceContrastText = true;
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
