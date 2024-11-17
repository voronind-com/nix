{
	config,
	...
}: let
	accent = config.module.style.color.accent  + alpha;
	alpha  = config.module.style.opacity.hex;
	border = config.module.style.color.border  + alpha;
	fg     = config.module.style.color.fg.light;
in {
	text = ''
		output * bg ${config.module.wallpaper.path} fill
		client.focused          "#${accent}" "#${accent}" "#${fg}" "#${accent}" "#${accent}"
		client.focused_inactive "#${border}" "#${border}" "#${fg}" "#${border}" "#${border}"
		client.unfocused        "#${border}" "#${border}" "#${fg}" "#${border}" "#${border}"
		client.urgent           "#${border}" "#${border}" "#${fg}" "#${border}" "#${border}"
		client.placeholder      "#${border}" "#${border}" "#${fg}" "#${border}" "#${border}"
	'';
}
