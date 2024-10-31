{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/Q8ZTZCH.png";
  sha256 = "sha256-HL3mJOeF6UKXL3ymj9ZynzgZTUJgw/lsxq9Xhpe3A8A=";
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
