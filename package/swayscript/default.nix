{
  __findFile,
  pkgs,
  util,
  ...
}:
let
  pipewire = pkgs.pipewire;
  longogg = <static/long.ogg>;
  notificationogg = <static/notification.ogg>;
  shortogg = <static/short.ogg>;

  raw = pkgs.writeText "swayscript-raw" (util.readFiles (util.ls ./script));
  script =
    (pkgs.replaceVars raw {
      inherit
        pipewire
        longogg
        notificationogg
        shortogg
        ;
    }).overrideAttrs
      (old: {
        doCheck = false;
      });
in
pkgs.writeShellScriptBin "swayscript" (builtins.readFile script + "\n\${@}")
