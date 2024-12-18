{
  __findFile,
  pkgs,
  util,
  ...
}:
let
  pipewire = pkgs.pipewire;
  longogg = <static/Long.ogg>;
  notificationogg = <static/Notification.ogg>;
  shortogg = <static/Short.ogg>;

  raw = pkgs.writeText "swayscript-raw" (util.readFiles (util.ls ./script));
  script = pkgs.replaceVars raw {
    inherit
      pipewire
      longogg
      notificationogg
      shortogg
      ;
  };
in
pkgs.writeShellScriptBin "swayscript" (builtins.readFile script + "\n\${@}")
