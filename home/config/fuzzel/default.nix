{
	pkgs,
	config,
	...
}: let
	dpiAware = if (config.module.dpi.aware or false) then "yes" else "no";
in {
	file = (pkgs.formats.ini { }).generate "FuzzelConfig" {
		main = {
			dpi-aware    = dpiAware;
			font         = "Minecraftia:size=${toString config.module.style.font.size.popup}";
			lines        = 20;
			prompt       = "\"\"";
			show-actions = "yes";
			terminal     = "foot";
			width        = 40;
		};
		border = {
			radius = 0;
			width  = 1;
		};
		colors = let
			defaultOpacity = "ff";
		in {
			background      = config.module.style.color.bg.dark    + config.module.style.opacity.hex;
			border          = config.module.style.color.border     + config.module.style.opacity.hex;
			counter         = config.module.style.color.bg.regular + defaultOpacity;
			input           = config.module.style.color.fg.light   + defaultOpacity;
			match           = config.module.style.color.fg.light   + defaultOpacity;
			placeholder     = config.module.style.color.bg.regular + defaultOpacity;
			prompt          = config.module.style.color.fg.light   + defaultOpacity;
			selection       = config.module.style.color.bg.regular + defaultOpacity;
			selection-match = config.module.style.color.accent     + defaultOpacity;
			selection-text  = config.module.style.color.fg.light   + defaultOpacity;
			text            = config.module.style.color.fg.light   + defaultOpacity;
		};
	};
}
