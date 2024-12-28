# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/AKsJ3Rl.jpeg";
  sha256 = "sha256-DIgboGiIGJb2bKi7zqb17m7jctEgWyrSI/mSypeV7dQ=";
  forceContrastText = false;

  # SEE: https://github.com/tinted-theming/schemes
  # Warm: "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml"
  style = null;
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
    style = lib.mkOption {
      default = style;
      type = with lib.types; nullOr (oneOf [ path lines attrs ]);
    };
  };
}
