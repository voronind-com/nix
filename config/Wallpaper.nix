{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/dOAieGp.png";
	sha256 = "1kv91k7rl3f45m9c3q9k5hlbmynr3p79hn7qwhj58qp183mvwm5d";
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
