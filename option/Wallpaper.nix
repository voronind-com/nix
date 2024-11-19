# Download the wallpaper here.
{
	pkgs,
	lib,
	...
}: let
	url    = "https://i.imgur.com/CLgD83W.jpeg";
	sha256 = "sha256-V5jkB6BHnYButDiTY5rVecnyrfh2lZIiB6GJ6NlBkHQ=";
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
