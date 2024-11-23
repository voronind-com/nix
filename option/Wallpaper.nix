# Download the wallpaper here.
{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/dX41s2V.jpeg";
	sha256 = "sha256-RU6tCWfEif8iK/A0dYmCWYXU0eFZFdDsW1tDuQdTjCA=";
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
