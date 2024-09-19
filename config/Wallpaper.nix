{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/3at96cg.jpeg";
	sha256 = "0jy6ni9iwycdb4n4ldgid2g23sprq9qjhl05mg0sl7kfjs8myywd";
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
