{ pkgs, ... }:
let
  apps = [
    "gimp"
    "gimp-*"
    # "steam-proton"
    # "steam-app-*"
  ];

  keys = [
    "escape"
    "leftcontrol"
  ];
in
{
  file =
    let
      keySets = builtins.map (key: {
        name = key;
        value = key;
      }) keys;

      appSets = builtins.map (app: {
        name = app;
        value = builtins.listToAttrs keySets;
      }) apps;
    in
    (pkgs.formats.ini { }).generate "keyd-disable-config" (builtins.listToAttrs appSets);
}
