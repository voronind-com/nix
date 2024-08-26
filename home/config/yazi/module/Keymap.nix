{ pkgs, ... }: {
	file = (pkgs.formats.toml {}).generate "YaziKeymapConfig" {
		manager = {
			prepend_keymap = [{
				on   = "d";
				run  = "remove --permanently";
				desc = "Dangerous life.";
			}];
		};
	};
}
