{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/LQJZPP2.jpeg";
	sha256 = "0kh1w638pkng7izwsj4ydvgipm8djhl8x1fi102hp476dbx7n6fi";
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
