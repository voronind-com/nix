{ pkgs, ... }:
let
  mkKeymap = desc: on: run: { inherit desc on run; };
in
{
  # REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap.toml
  file = (pkgs.formats.toml { }).generate "YaziKeymapConfig" {
    manager = {
      prepend_keymap = [
        (mkKeymap "Delete" "d" "remove --permanently")
        (mkKeymap "Delete no questions asked" "D" "remove --permanently --force")
        (mkKeymap "Spawn shell here" "<Enter>" ''shell "SHELL_NAME=yazi $SHELL" --block --confirm'')
        (mkKeymap "Open interactively" "o" "open --interactive")
        (mkKeymap "Open default" "O" "open")
        (mkKeymap "Rename completely" "R" "rename --empty all")
        (mkKeymap "Close tab" "c" "close")
        # I wanna die thanks to nixfmt.
        (mkKeymap "Go to storage" [
          "g"
          "s"
        ] "cd /storage")
        (mkKeymap "Go to tmp" [
          "g"
          "t"
        ] "cd ~/tmp")
        (mkKeymap "Go to system tmp" [
          "g"
          "T"
        ] "cd /tmp")
        (mkKeymap "Go to projects" [
          "g"
          "p"
        ] "cd ~/project")
        # Yazi devs are... special.
        (mkKeymap "Go to downloads" [
          "g"
          "d"
        ] "cd $XDG_DOWNLOAD_DIR")
        (mkKeymap "Go to configs" [
          "g"
          "c"
        ] "cd $XDG_CONFIG_HOME")
      ];
    };
  };
}
