# Download the wallpaper here.
{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/AVWdqBy.jpeg";
	sha256 = "sha256-GhOHOyENrfO98zmIfYjzPioX+CyJ3eiq5nF6N/2p3Dw=";
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
