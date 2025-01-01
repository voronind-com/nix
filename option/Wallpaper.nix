# Download the wallpaper here.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.wallpaper;

  url = "https://www.desktophut.com/files/YodlHKEufG9PuGV_Cat%20Lofi%20Live%20Wallpaper.mp4";
  sha256 = "sha256-l76+wlP0Jb/ULqN4bX8eqdwKnIlbOwO3HuCV1DPoXOE=";
  video = true;

  # Forse black and white for text.
  forceContrastText = false;

  # Predefined scheme instead of generated.
  # SEE: /etc/stylix/palette.json
  # SEE: https://github.com/tinted-theming/schemes
  # scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  scheme = null;

  # Extract image from video.
  videoImage =
    if video then
      pkgs.runCommandNoCC "wallpaper-video-image" { } ''
        ${pkgs.ffmpeg}/bin/ffmpeg -hide_banner -loglevel error -ss 00:00:00 -i ${cfg.videoPath} -frames:v 1 -q:v 1 Image.jpg
        cp Image.jpg $out
      ''
    else
      null;
in
{
  options.module.wallpaper = {
    forceContrastText = lib.mkOption {
      default = lib.warnIf forceContrastText "Wallpaper: Forced text contrast." forceContrastText;
      type = lib.types.bool;
    };
    path = lib.mkOption {
      default = if video then videoImage else pkgs.fetchurl { inherit url sha256; };
      type = lib.types.path;
    };
    video = lib.mkOption {
      default = video;
      type = lib.types.bool;
    };
    videoPath = lib.mkOption {
      default = if video then pkgs.fetchurl { inherit url sha256; } else null;
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
