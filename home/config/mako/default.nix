{ pkgs, config, ... }: let
	alpha = config.style.opacity.hex;
in {
	file = (pkgs.formats.iniWithGlobalSection {}).generate "MakoConfig" {
		globalSection = {
			anchor           = "top-center";
			background-color = "#${config.style.color.bg.dark}${alpha}";
			border-color     = "#${config.style.color.border}${alpha}";
			default-timeout  = 10000;
			font             = "${config.style.font.serif.name} ${toString config.style.font.size.popup}";
			height           = 120;
			icons            = 0;
			margin           = 32;
			text-color       = "#${config.style.color.fg.light}";
			width            = 480;
		};

		sections = {
			"mode=dnd" = {
				invisible = 1;
			};
		};
	};
}
