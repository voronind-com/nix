{ pkgs, lib, ... }:
with lib;
let
  url = "https://i.imgur.com/yuZ2XSf.jpeg";
  sha256 = "sha256-Z35D7gn28d2dtPHHVwzySOingy/d8CWKmK9LQjpyjEk=";
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
