{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/iDuNPOQ.jpeg";
  sha256 = "1hyzc53jkmjkhabbzx4nxzg5bqrk2524dl167fs5aw58r8q6fr75";
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
