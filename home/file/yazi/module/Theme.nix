{
	pkgs,
	config,
	...
}: let
	color = config.module.style.color;
	border = {
		fg = "#${color.border}";
	};
	borderLight = {
		fg = "#${color.accent}";
	};
	hover = {
		bg = "#${color.bg.regular}";
		fg = "#${color.fg.light}";
	};
	select = {
		bg = "#${color.selection}";
		fg = "#${color.fg.dark}";
	};
	text = {
		fg = "#${color.fg.light}";
	};
in {
	# REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/theme.toml
	file = (pkgs.formats.toml { }).generate "YaziThemeConfig" {
		manager = let
			mkMarker = markerColor: {
				bg = "#${markerColor}";
				fg = "#${markerColor}";
			};

			mkCounter = counterColor: {
				bg = "#${counterColor}";
				fg = "#${color.fg.light}";
			};
		in {
			border_style    = border;
			border_symbol   = " ";
			count_copied    = mkCounter color.positive;
			count_cut       = mkCounter color.negative;
			count_selected  = mkCounter color.neutral;
			cwd             = text;
			hovered         = hover;
			marker_copied   = mkMarker color.accent;
			marker_cut      = mkMarker color.accent;
			marker_marked   = mkMarker color.highlight;
			marker_selected = mkMarker color.selection;
			preview_hovered = hover;
			tab_active      = mkCounter color.selection;
		};
		select = {
			active   = select;
			border   = borderLight;
			inactive = text;
		};
		input = {
			border   = borderLight; # ISSUE: Currently broken, stays blue.
			selected = select;
			title    = borderLight;
			value    = text;
		};
		completion = {
			active   = hover;
			border   = borderLight;
			inactive = text;
		};
		tasks = {
			border  = borderLight;
			hovered = hover;
			title   = borderLight;
		};
		which = {
			cand = text;
			cols = 3;
			desc = text;
			mask = hover;
			rest = text;
			separator       = " - ";
			separator_style = text;
		};
		help = {
			desc    = text;
			footer  = text;
			hovered = hover;
			on      = text;
			run     = text;
		};
		confirm = {
			border = borderLight;
			title  = borderLight;
		};
		status = {
			mode_normal     = hover;
			mode_select     = select;
			permissions_r   = text;
			permissions_s   = text;
			permissions_t   = text;
			permissions_w   = text;
			permissions_x   = text;
			progress_label  = hover;
			progress_normal = hover;
			separator_close = "";
			separator_open  = "";
			# NOTE: Inversed because yazi dev is fckin weird. Also add manpages ffs.
			separator_style = {
				bg = "#${config.module.style.color.fg.light}";
				fg = "#${config.module.style.color.bg.regular}";
			};
			mode_unset = {
				bg = "#${config.module.style.color.neutral}";
				fg = "#${config.module.style.color.fg.light}";
			};
			progress_error = {
				bg = "#${config.module.style.color.negative}";
				fg = "#${config.module.style.color.fg.light}";
			};
		};
	};
}
