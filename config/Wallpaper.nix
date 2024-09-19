{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/ipyHU1p.jpeg";
	sha256 = "0i065hak4r7rn041qy8bbkscbi87vjz414b5wbfnjp7wrqyph49i";
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
