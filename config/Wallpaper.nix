{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/7PoLqMb.jpeg";
  sha256 = "1vwhgdxsfn33pcyw06b2f5xikz6iwp4h54lr8515fqnnzbl06vjm";
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
