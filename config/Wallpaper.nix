{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/FdOgt6q.png";
	sha256 = "0in90ap2bqfii4ly0c1h2shp2xrgbcvfdh1pxd63fdvyb99x0r47";
	forceContrastText = true;
in {
	options = {
		module.wallpaper = {
			forceContrastText = mkOption {
				default = warnIf forceContrastText "Style : Forced text contrast." forceContrastText;
				type    = types.bool;
			};
			path = mkOption {
				default = pkgs.fetchurl { inherit url sha256; };
				type    = types.path;
			};
		};
	};
}
