{ pkgs, ... }:
{
  # REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap.toml
  file = (pkgs.formats.toml { }).generate "YaziKeymapConfig" {
    manager = {
      prepend_keymap = [
        {
          on = "<Enter>";
          desc = "Spawn shell here";
          run = ''shell "SHELL_NAME=yazi $SHELL" --block --confirm'';
        }
        {
          on = "<Tab>";
          desc = "New tab";
          run = "tab_create --current";
        }
        {
          on = "?";
          desc = "Show help";
          run = "help";
        }
        {
          on = "D";
          desc = "Force delete";
          run = "remove --permanently --force";
        }
        {
          on = "E";
          desc = "Move to next tab";
          run = "tab_swap 1 --relative";
        }
        {
          on = "O";
          desc = "Open default";
          run = "open";
        }
        {
          on = "Q";
          desc = "Move to prev tab";
          run = "tab_swap -1 --relative";
        }
        {
          on = "R";
          desc = "Rename completely";
          run = "rename --empty=stem --cursor=start";
        }
        {
          on = "Z";
          desc = "Exit yazi";
          run = "quit";
        }
        {
          on = "=";
          desc = "Hardlink";
          run = "hardlink --follow";
        }
        {
          on = "d";
          desc = "Delete";
          run = "remove --permanently";
        }
        {
          on = "e";
          desc = "Next tab";
          run = "tab_switch 1 --relative";
        }
        {
          on = "o";
          desc = "Open interactively";
          run = "open --interactive";
        }
        {
          on = "q";
          desc = "Prev tab";
          run = "tab_switch -1 --relative";
        }
        {
          on = "z";
          desc = "Close tab";
          run = "close";
        }
        {
          on = [
            "g"
            "M"
          ];
          desc = "Go to mnt";
          run = "cd /mnt";
        }
        {
          on = [
            "g"
            "R"
          ];
          desc = "Go to root";
          run = "cd /";
        }
        {
          on = [
            "g"
            "S"
          ];
          desc = "Go to storage";
          run = "cd /storage";
        }
        {
          on = [
            "g"
            "T"
          ];
          desc = "Go to system tmp";
          run = "cd /tmp";
        }
        {
          on = [
            "g"
            "U"
          ];
          desc = "Go to user";
          run = "cd /run/user/$UID";
        }
        # { on = [ "g" "c" ]; desc = "Go to configs";      run = "noop"; }
        {
          on = [
            "g"
            "d"
          ];
          desc = "Go to downloads";
          run = "cd $XDG_DOWNLOAD_DIR";
        }
        {
          on = [
            "g"
            "l"
          ];
          desc = "Go to locker";
          run = "cd ~/locker";
        }
        {
          on = [
            "g"
            "n"
          ];
          desc = "Go to nix";
          run = "cd ~/nix";
        }
        {
          on = [
            "g"
            "p"
          ];
          desc = "Go to project";
          run = "cd ~/project";
        }
        {
          on = [
            "g"
            "s"
          ];
          desc = "Go to sync";
          run = "cd ~/sync";
        }
        {
          on = [
            "g"
            "t"
          ];
          desc = "Go to tmp";
          run = "cd ~/tmp";
        }
        {
          on = [
            "g"
            "w"
          ];
          desc = "Go to game";
          run = "cd ~/game";
        }
      ];
    };
  };
}
