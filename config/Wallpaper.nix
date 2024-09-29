{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/44bzkA9.jpeg";
	sha256 = "16xwi6n76vgkj97nqs9pxrd4px939izjfs7ns4qmylimkvmaiyd8";
	forceContrastText = false;
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
