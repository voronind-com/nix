# Download the wallpaper here.
{
	pkgs,
	lib,
	...
}: let
	url    = "https://images.unsplash.com/photo-1482517967863-00e15c9b44be?ixlib=rb-4.0.3&q=85&fm=jpg&crop=entropy&cs=srgb&dl=chad-madden-SUTfFCAHV_A-unsplash.jpg";
	sha256 = "sha256-3T8Spa+gsemiyDcqBQCwZfWU1MWzu2AhPDF4wyeXxcQ=";
	forceContrastText = false;
in {
	options.module.wallpaper = {
		forceContrastText = lib.mkOption {
			default = lib.warnIf forceContrastText "Wallpaper: Forced text contrast." forceContrastText;
			type    = lib.types.bool;
		};
		path = lib.mkOption {
			default = pkgs.fetchurl { inherit url sha256; };
			type    = lib.types.path;
		};
	};
}
