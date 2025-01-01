{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.wallpaper;
in
{
  config = lib.mkMerge [
    (lib.mkIf (cfg.videoPath != null) {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "wallpaper-video" ''
          mpvpaper -o 'no-audio --loop-file --panscan=1' '*' ${cfg.videoPath}
        '')
      ];
    })
  ];
}
