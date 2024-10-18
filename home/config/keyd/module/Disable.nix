{ pkgs, ... }:
let
  apps = [
    "*|gnu-image-manipulation-program"
    "steam-proton"
  ];

  keys = [
    "escape"
    "leftcontrol"
  ];
in
{
  file = (pkgs.formats.ini { }).generate "KeydDisableConfig" (
    builtins.listToAttrs (
      builtins.map (app: {
        name = app;
        value = builtins.listToAttrs (
          builtins.map (key: {
            name = key;
            value = key;
          }) keys
        );
      }) apps
    )
  );
}
