{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/Ni17fLc.jpeg";
	sha256 = "0ms6ip1fqpcn55diqjwrgf3km0m3cgbz9cyy1glfhr0rbrvnfhaf";
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
