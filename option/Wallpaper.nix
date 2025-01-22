{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.wallpaper;
  purpose = config.module.purpose;

  # Set the wallpaper here.
  url = "https://share.voronind.com/wallpaper/LiveWallpaperPcComCooltropolis3840X2160.mp4";
  sha256 = "sha256-MJDuQpAwiwIz1nv7BuOJPvK0VL1OSnyFOTeOwVQnWBU=";
  video = true;

  # Forse black and white for text.
  forceContrastText = false;

  # Predefined scheme instead of generated.
  # SEE: /etc/stylix/palette.json
  # SEE: https://github.com/tinted-theming/schemes
  # scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  scheme = null;

  # Extract image from video.
  videoPath = if video then pkgs.fetchurl { inherit url sha256; } else null;
  image =
    if video then
      pkgs.runCommandNoCC "wallpaper-video-image" { } ''
        ${pkgs.ffmpeg}/bin/ffmpeg -hide_banner -loglevel error -ss 00:00:00 -i ${videoPath} -frames:v 1 -q:v 1 Image.jpg
        mv Image.jpg $out
      ''
    else
      pkgs.fetchurl { inherit url sha256; };
in
{
  options.module.wallpaper = {
    forceContrastText = lib.mkOption {
      default = lib.warnIf forceContrastText "Wallpaper: Forced text contrast." forceContrastText;
      type = lib.types.bool;
    };
    path = lib.mkOption {
      default = image;
      type = lib.types.path;
    };
    video = lib.mkOption {
      default = video && purpose.desktop;
      type = lib.types.bool;
    };
    videoPath = lib.mkOption {
      default = videoPath;
      type = with lib.types; nullOr path;
    };
    scheme = lib.mkOption {
      default = scheme;
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
