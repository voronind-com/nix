# Download the wallpaper here.
{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/SNEPYVe.jpeg";
	sha256 = "sha256-cOddztn8w3lJrfMINWQnplacV8eubsatTz73oTMo2bk=";
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
