{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/M5Vadxh.jpeg";
	sha256 = "1pfam0gy82w4f433n96mns5vyqb0pi32g486swiw7xqzi62z241p";
	forceContrastText = false;
in {
	options = {
		module.wallpaper = {
			forceContrastText = mkOption {
				default = lib.warnIf forceContrastText "Style : Forced text contrast." forceContrastText;
				type    = types.bool;
			};
			path = mkOption {
				default = pkgs.fetchurl { inherit url sha256; };
				type    = types.path;
			};
		};
	};
}
