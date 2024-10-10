{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/gYy0mzG.jpeg";
	sha256 = "0pwnq84mdbv8nrarhnbkq77iabwgh7znr0yig3fnshamxl2a3k7k";
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
