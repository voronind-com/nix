{ pkgs, ... }: {
	file = (pkgs.formats.toml {}).generate "YaziKeymapConfig" {
		manager = {
			prepend_keymap = [
				{
					on   = "d";
					run  = "remove --permanently";
					desc = "Dangerous life.";
				}
				{
					on   = "D";
					run  = "remove --permanently --force";
					desc = "Dangerous life.";
				}
				{
					on   = "a";
					run  = "create --dir";
					desc = "Who wants files anyway?";
				}
			];
		};
	};
}
