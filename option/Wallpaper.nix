# Download the wallpaper here.
{ pkgs, lib, ... }:
let
  url = "https://i.imgur.com/KkZFMD3.png";
  sha256 = "sha256-cTNUeamZTjQDx8gGZkU1mj4kKS3FEE0+EDzFb5bsyZE=";
  forceContrastText = false;

  # SEE: https://github.com/tinted-theming/schemes
  # Blue:     "${pkgs.base16-schemes}/share/themes/moonlight.yaml"
  # Brown:    "${pkgs.base16-schemes}/share/themes/sandcastle.yaml"
  # Classy:   "${pkgs.base16-schemes}/share/themes/monokai.yaml"
  # Cold:     "${pkgs.base16-schemes}/share/themes/nord.yaml"
  # Cool:     "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml"
  # Gray:     "${pkgs.base16-schemes}/share/themes/nova.yaml"
  # Material: "${pkgs.base16-schemes}/share/themes/material.yaml"
  # Purple:   "${pkgs.base16-schemes}/share/themes/shades-of-purple.yaml"
  # Retro:    "${pkgs.base16-schemes}/share/themes/mocha.yaml"
  # Warm:     "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml"
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
      type =
        with lib.types;
        nullOr (oneOf [
          path
          lines
          attrs
        ]);
    };
  };
}
