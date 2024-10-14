{ pkgs, ... }:
let
  disable = [
  ];
in
{
  file = (pkgs.formats.ini { }).generate "KeydDisableConfig" (
    builtins.listToAttrs (builtins.map (app:
      {
        name = app;
        value = {
          "capslock" = "capslock";
          "escape" = "escape";
          "leftcontrol" = "leftcontrol";
        };
      }
    ) disable)
  );
}
