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
  url = "https://share.voronind.com/wallpaper/332bc6e7ea2e8c1119bb1e1ce243acfa17d312b3.mp4";
  sha256 = "sha256-Z4H06S6YGdfWlJ8PZCzWx923DYWr78GK4v18/SGYlRY=";
  video = true;
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
        ${pkgs.ffmpeg}/bin/ffmpeg -hide_banner -loglevel error -ss 00:00:00 -i ${videoPath} -vf "select=eq(n\,0)" -q:v 2 frame.jpg
        mv frame.jpg $out
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
