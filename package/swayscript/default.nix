{
  __findFile,
  config,
  pkgs,
  util,
  ...
}:
let
  inherit (config.module.display) logo;
  longogg = <static/long.ogg>;
  notificationogg = <static/notification.ogg>;
  shortogg = <static/short.ogg>;

  raw = pkgs.writeText "swayscript-raw" (util.readFiles (util.ls ./script));
  script =
    (pkgs.replaceVars raw {
      inherit
        logo
        longogg
        notificationogg
        shortogg
        ;
      inherit (pkgs) pipewire;
    }).overrideAttrs
      (old: {
        doCheck = false;
      });
in
pkgs.writeShellScriptBin "swayscript" (builtins.readFile script + "\n\${@}")
