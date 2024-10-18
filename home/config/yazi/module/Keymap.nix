{ pkgs, ... }:
{
  file = (pkgs.formats.toml { }).generate "YaziKeymapConfig" {
    manager = {
      prepend_keymap = [
        {
          desc = "Dangerous life";
          on = "d";
          run = "remove --permanently";
        }
        {
          desc = "Dangerous life";
          on = "D";
          run = "remove --permanently --force";
        }
        {
          desc = "Spawn shell here";
          on = "<Enter>";
          run = ''shell "SHELL_NAME=yazi $SHELL" --block --confirm'';
        }
        {
          desc = "Open interactively";
          on = "o";
          run = "open --interactive";
        }
        {
          desc = "Open default";
          on = "O";
          run = "open";
        }
      ];
    };
  };
}
