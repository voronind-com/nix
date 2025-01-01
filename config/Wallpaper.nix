{ config, pkgs, ... }:
let
  cfg = config.module.wallpaper;
in
{
  config = {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "wallpaper-video" ''
        mpvpaper -o 'no-audio --loop-file --panscan=1' '*' ${cfg.videoPath}
      '')
    ];
  };
}
