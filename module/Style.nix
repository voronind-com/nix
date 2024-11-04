{
	__findFile,
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.style;

	mkTypeOption  = default: type: lib.mkOption { inherit default type; };
	mkFloatOption = default: mkTypeOption default lib.types.float;
	mkIntOption   = default: mkTypeOption default lib.types.int;
	mkPkgOption   = default: mkTypeOption default lib.types.package;
	mkStrOption   = default: mkTypeOption default lib.types.str;
in {
	options.module.style = {
		color = {
			accent    = mkStrOption config.lib.stylix.colors.base0A;
			heading   = mkStrOption config.lib.stylix.colors.base0D;
			hl        = mkStrOption config.lib.stylix.colors.base03;
			keyword   = mkStrOption config.lib.stylix.colors.base0E;
			link      = mkStrOption config.lib.stylix.colors.base09;
			misc      = mkStrOption config.lib.stylix.colors.base0F;
			negative  = mkStrOption config.lib.stylix.colors.base08;
			neutral   = mkStrOption config.lib.stylix.colors.base0C;
			positive  = mkStrOption config.lib.stylix.colors.base0B;
			selection = mkStrOption config.lib.stylix.colors.base02;
			bg = {
				dark    = mkStrOption config.lib.stylix.colors.base00;
				light   = mkStrOption config.lib.stylix.colors.base07;
				regular = mkStrOption config.lib.stylix.colors.base01;
			};
			fg = {
				dark    = mkStrOption config.lib.stylix.colors.base04;
				light   = mkStrOption config.lib.stylix.colors.base06;
				regular = mkStrOption config.lib.stylix.colors.base05;
			};

			accent-r = mkStrOption config.lib.stylix.colors.base0A-rgb-r;
			accent-g = mkStrOption config.lib.stylix.colors.base0A-rgb-g;
			accent-b = mkStrOption config.lib.stylix.colors.base0A-rgb-b;

			bg-r = mkStrOption config.lib.stylix.colors.base00-rgb-r;
			bg-g = mkStrOption config.lib.stylix.colors.base00-rgb-g;
			bg-b = mkStrOption config.lib.stylix.colors.base00-rgb-b;

			border   = mkStrOption config.lib.stylix.colors.base01;
			border-r = mkStrOption config.lib.stylix.colors.base01-rgb-r;
			border-g = mkStrOption config.lib.stylix.colors.base01-rgb-g;
			border-b = mkStrOption config.lib.stylix.colors.base01-rgb-b;

			fg-r = mkStrOption config.lib.stylix.colors.base06-rgb-r;
			fg-g = mkStrOption config.lib.stylix.colors.base06-rgb-g;
			fg-b = mkStrOption config.lib.stylix.colors.base06-rgb-b;

			negative-r = mkStrOption config.lib.stylix.colors.base08-rgb-r;
			negative-g = mkStrOption config.lib.stylix.colors.base08-rgb-g;
			negative-b = mkStrOption config.lib.stylix.colors.base08-rgb-b;

			neutral-r = mkStrOption config.lib.stylix.colors.base0C-rgb-r;
			neutral-g = mkStrOption config.lib.stylix.colors.base0C-rgb-g;
			neutral-b = mkStrOption config.lib.stylix.colors.base0C-rgb-b;

			positive-r = mkStrOption config.lib.stylix.colors.base0B-rgb-r;
			positive-g = mkStrOption config.lib.stylix.colors.base0B-rgb-g;
			positive-b = mkStrOption config.lib.stylix.colors.base0B-rgb-b;

			transparent = mkStrOption "ffffff00";
		};

		cursor = {
			name    = mkStrOption "phinger-cursors-light";
			package = mkPkgOption pkgs.phinger-cursors;
			size    = mkIntOption 24;
		};

		font = {
			emoji = {
				name    = mkStrOption "Noto Color Emoji";
				package = mkPkgOption pkgs.noto-fonts-emoji;
			};
			monospace = {
				name    = mkStrOption "Terminess Nerd Font Mono";
				package = mkPkgOption (pkgs.nerdfonts.override { fonts = [ "Terminus" ]; });
			};
			sansSerif = {
				name    = mkStrOption "SF Pro Display";
				package = mkPkgOption (pkgs.callPackage <package/applefont> { });
			};
			serif = {
				name    = mkStrOption "SF Pro Display";
				package = mkPkgOption (pkgs.callPackage <package/applefont> { });
			};
			size = {
				application = mkIntOption 12;
				desktop     = mkIntOption 14;
				popup       = mkIntOption 12;
				terminal    = mkIntOption 14;
			};
		};

		opacity = {
			application = mkFloatOption 0.85;
			desktop     = mkFloatOption 0.85;
			hex         = mkStrOption "D9";
			popup       = mkFloatOption 0.85;
			terminal    = mkFloatOption 0.85;
		};

		window = {
			border = mkIntOption 4;
			gap    = mkIntOption 8;
		};
	};
}
