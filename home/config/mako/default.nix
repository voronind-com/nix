{
	__findFile,
	config,
	pkgs,
	...
}: let
	alpha = config.module.style.opacity.hex;
	color = config.module.style.color;
in {
	file = (pkgs.formats.iniWithGlobalSection { }).generate "MakoConfig" {
		globalSection = {
			anchor           = "top-center";
			background-color = "#${color.hl}${alpha}";
			border-color     = "#${color.border}${alpha}";
			default-timeout  = 10000;
			font             = "${config.module.style.font.serif.name} ${toString config.module.style.font.size.popup}";
			height           = 120;
			icons            = 0;
			margin           = 32;
			max-visible      = 1;
			on-notify        = "exec ${pkgs.pipewire}/bin/pw-cat -p ${<static/Notification.ogg>}";
			text-color       = "#${config.module.style.color.bg.dark}";
			width            = 480;
		};
		sections = {
			"mode=dnd" = {
				invisible = 1;
				on-notify = "exec ${pkgs.coreutils}/bin/true";
			};
		};
	};
}
