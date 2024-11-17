{
	config,
	...
}: let
	accent = config.module.style.color.accent  + alpha;
	alpha  = config.module.style.opacity.hex;
	bg     = config.module.style.color.bg.dark + alpha;
	border = config.module.style.color.border  + alpha;
	fg     = config.module.style.color.fg.light;
in {
	text = ''
		output * bg ${config.module.wallpaper.path} fill
		client.focused          "#${accent}" "#${accent}" "#${fg}" "#${accent}" "#${accent}"
		client.focused_inactive "#${border}" "#${bg}"     "#${fg}" "#${border}" "#${border}"
		client.unfocused        "#${border}" "#${bg}"     "#${fg}" "#${border}" "#${border}"
		client.urgent           "#${border}" "#${bg}"     "#${fg}" "#${border}" "#${border}"
		client.placeholder      "#${bg}"     "#${bg}"     "#${fg}" "#${bg}"     "#${bg}"
	'';
}
