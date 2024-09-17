{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/V4tgLqr.jpeg";
	sha256 = "0c7a8ckacqx5jiqj3zcykxn1cwafb860ysffjvjgijwsvbkz31qz";
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
