{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/9l6Ywcm.jpeg";
  sha256 = "1fncihr63niq6l2llgbhhid24a11vr3q091yya497xld3mldfdan";
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
