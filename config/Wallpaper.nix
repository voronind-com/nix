{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/OpZzgJZ.png";
	sha256 = "0rzcpqx4m6lg91nx465qs4flvnad4cqqr1prl0ky24r5vz3z87z5";
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
