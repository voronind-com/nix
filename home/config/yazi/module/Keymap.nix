{ pkgs, ... }:
{
  file = (pkgs.formats.toml { }).generate "YaziKeymapConfig" {
    manager = {
      prepend_keymap = [
        {
          on = "d";
          run = "remove --permanently";
          desc = "Dangerous life.";
        }
        {
          on = "D";
          run = "remove --permanently --force";
          desc = "Dangerous life.";
        }
        {
          on = "a";
          run = "create --dir";
          desc = "Who wants files anyway?";
        }
        {
          on = "A";
          run = "create --force";
          desc = "I want, sometimes.";
        }
        {
          on = "<Enter>";
          run = ''shell "SHELL_NAME=yazi $SHELL" --block --confirm'';
          desc = "Spawn shell here.";
        }
      ];
    };
  };
}
