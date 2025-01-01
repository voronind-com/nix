{ config, lib, pkgs, ... }: let
  cfg = config.module.wallpaper;
in {
  config = lib.mkMerge [
    (lib.mkIf cfg.video {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "mpvpaper-sway" ''
          mpvpaper -o 'no-audio --loop-file --panscan=1' '*' ${cfg.videoPath}
        '')
      ];
    })
  ];
}
