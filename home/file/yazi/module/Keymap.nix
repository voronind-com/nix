{
	pkgs,
	...
}: {
	# REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap.toml
	file = (pkgs.formats.toml { }).generate "YaziKeymapConfig" {
		manager = {
			prepend_keymap = [
				{ on = "<Enter>";   desc = "Spawn shell here";   run = ''shell "SHELL_NAME=yazi $SHELL" --block --confirm''; }
				{ on = "<Tab>";     desc = "New tab";            run = "tab_create --current"; }
				{ on = "?";         desc = "Show help";          run = "help"; }
				{ on = "D";         desc = "Force delete";       run = "remove --permanently --force"; }
				{ on = "E";         desc = "Move to next tab";   run = "tab_swap 1 --relative"; }
				{ on = "O";         desc = "Open default";       run = "open"; }
				{ on = "Q";         desc = "Move to prev tab";   run = "tab_swap -1 --relative"; }
				{ on = "R";         desc = "Rename completely";  run = "rename --empty=all"; }
				{ on = "Z";         desc = "Exit yazi";          run = "quit"; }
				{ on = "d";         desc = "Delete";             run = "remove --permanently"; }
				{ on = "e";         desc = "Next tab";           run = "tab_switch 1 --relative"; }
				{ on = "o";         desc = "Open interactively"; run = "open --interactive"; }
				{ on = "q";         desc = "Prev tab";           run = "tab_switch -1 --relative"; }
				{ on = "z";         desc = "Close tab";          run = "close"; }
				{ on = [ "g" "T" ]; desc = "Go to system tmp";   run = "cd /tmp"; }
				{ on = [ "g" "c" ]; desc = "Go to configs";      run = "noop"; }
				{ on = [ "g" "d" ]; desc = "Go to downloads";    run = "cd $XDG_DOWNLOAD_DIR"; }
				{ on = [ "g" "m" ]; desc = "Go to mnt";          run = "cd /mnt"; }
				{ on = [ "g" "p" ]; desc = "Go to projects";     run = "cd ~/project"; }
				{ on = [ "g" "r" ]; desc = "Go to root";         run = "cd /"; }
				{ on = [ "g" "s" ]; desc = "Go to storage";      run = "cd /storage"; }
				{ on = [ "g" "t" ]; desc = "Go to tmp";          run = "cd ~/tmp"; }
				{ on = [ "g" "u" ]; desc = "Go to user";         run = "cd /run/user/$UID"; }
			];
		};
	};
}
