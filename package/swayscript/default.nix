{
  __findFile,
  config,
  pkgs,
  util,
  ...
}:
let
  logo = config.module.display.logo;
  longogg = <static/long.ogg>;
  notificationogg = <static/notification.ogg>;
  pipewire = pkgs.pipewire;
  shortogg = <static/short.ogg>;

  raw = pkgs.writeText "swayscript-raw" (util.readFiles (util.ls ./script));
  script =
    (pkgs.replaceVars raw {
      inherit
        logo
        longogg
        notificationogg
        pipewire
        shortogg
        ;
    }).overrideAttrs
      (old: {
        doCheck = false;
      });
in
pkgs.writeShellScriptBin "swayscript" (builtins.readFile script + "\n\${@}")
