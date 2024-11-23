{
	pkgs,
	config,
	...
}: {
	config = (pkgs.formats.ini { }).generate "SwappyConfig" {
		Default = {
			custom_color = with config.module.style.color; "rgba(${accent-r},${accent-g},${accent-b},1)";
			early_exit   = true;
			fill_shape   = false;
			line_size    = 4;
			paint_mode   = "arrow";
			show_panel   = false;
			text_font    = config.module.style.font.serif.name;
			text_size    = config.module.style.font.size.popup * 3;
		};
	};
}
