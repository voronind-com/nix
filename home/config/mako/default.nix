{
	pkgs,
	config,
	...
}: let
	alpha = config.module.style.opacity.hex;
	color = config.module.style.color;
in {
	file = (pkgs.formats.iniWithGlobalSection { }).generate "MakoConfig" {
		globalSection = {
			anchor           = "top-center";
			background-color = "#${color.selection}${alpha}";
			border-color     = "#${color.border}${alpha}";
			default-timeout  = 10000;
			font             = "${config.module.style.font.serif.name} ${toString config.module.style.font.size.popup}";
			height           = 120;
			icons            = 0;
			margin           = 32;
			text-color       = "#${config.module.style.color.fg.dark}";
			width            = 480;
		};
		sections = {
			"mode=dnd" = {
				invisible = 1;
			};
		};
	};
}
