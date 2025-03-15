{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.wallpaper;
  purpose = config.module.purpose;
  hasGpu = config.module.amd.gpu.enable;

  # Set the wallpaper here.
  url = "https://share.voronind.com/wallpaper/live_wallpaper_pc.com-girl-and-cats-on-a-snowy-day-3840_x_2160.mp4";
  sha256 = "sha256-TmiR/qXsdAj8KHQfo3HI5KprHKSKWEvtUGOgpLKnWOY=";
  video = true;

  # Forse black and white for text.
  forceContrastText = true;

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
        ${pkgs.ffmpeg}/bin/ffmpeg -hide_banner -loglevel error -ss 00:00:00 -i ${videoPath} -vf "select=eq(n\,0)" -q:v 2 Image.jpg
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
      default = video && hasGpu && purpose.desktop;
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
