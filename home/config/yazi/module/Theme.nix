{ pkgs, config, ... }: let
	border = {
		fg = "#${config.style.color.border}";
	};
	borderLight = {
		fg = "#${config.style.color.accent}";
	};
in {
	file = (pkgs.formats.toml {}).generate "YaziThemeConfig" {
		manager = {
			border_style  = border;
			border_symbol = " ";
			cwd = {
				fg = "#${config.style.color.fg.light}";
				# bg = "#${style.color.bg.regular}";
			};
			hovered = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.bg.regular}";
			};
			preview_hovered = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.bg.regular}";
			};
			tab_active = {
				bg = "#${config.style.color.accent}";
			};
		};
		select     = { border = borderLight; };
		input      = { border = borderLight; };
		completion = { border = borderLight; };
		tasks      = { border = borderLight; };

		status = {
			separator_open  = "";
			separator_close = "";
			# NOTE: Inversed because yazi dev is fckin weird. Also add manpages ffs.
			separator_style = {
				bg = "#${config.style.color.fg.light}";
				fg = "#${config.style.color.bg.regular}";
			};
			mode_normal = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.bg.regular}";
			};
			mode_select = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.selection}";
			};
			mode_unset = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.neutral}";
			};
			progress_label = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.bg.regular}";
			};
			progress_normal = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.bg.regular}";
			};
			progress_error = {
				fg = "#${config.style.color.fg.light}";
				bg = "#${config.style.color.negative}";
			};
			permissions_t = {
				fg = "#${config.style.color.fg.light}";
			};
			permissions_r = {
				fg = "#${config.style.color.fg.light}";
			};
			permissions_w = {
				fg = "#${config.style.color.fg.light}";
			};
			permissions_x = {
				fg = "#${config.style.color.fg.light}";
			};
			permissions_s = {
				fg = "#${config.style.color.fg.light}";
			};
		};
	};
}
