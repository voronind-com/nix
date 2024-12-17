# Download the wallpaper here.
{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/XG8bA49.jpeg";
	sha256 = "sha256-xVdZ8wSN+PMoX1z7mdF9d4Gklxt41jASvz/LYtfGosE=";
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
