{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/Btbcst7.jpeg";
	sha256 = "sha256-9FXsUep7wgVC3HPJv9t5lXgxJD4YdLL4bfr/CHrvmlk=";
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