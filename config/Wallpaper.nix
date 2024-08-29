{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/HjRpaif.jpeg";
	sha256 = "1fs4y8l87g0c74pxihcscsd3c51d05d3wqc3619llcn01xicv9mm";
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
