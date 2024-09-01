{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/tGvCgEe.jpeg";
	sha256 = "18m2v6imhhrmvi65vgw487p4wz18lb3v2jrcmjrjz8412w210rln";
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
