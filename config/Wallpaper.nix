{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/RJMSMgF.jpeg";
	sha256 = "0063fcgmdj0nalqisxg8lm9gvksw9n24ry4gr53pdxwaz902xk2m";
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
