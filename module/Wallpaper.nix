{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/yuZ2XSf.jpeg";
	sha256 = "sha256-Z35D7gn28d2dtPHHVwzySOingy/d8CWKmK9LQjpyjEk=";
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
