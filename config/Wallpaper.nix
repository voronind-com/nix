{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/yBQicIG.jpeg";
	sha256 = "1j1s5vfidsqja5vsa3i8is8z5r3vh2dqsvfzpra8gdzah7hkz2sk";
	forceContrastText = false;
in {
	options = {
		module.wallpaper = {
			forceContrastText = mkOption {
				default = forceContrastText;
				type    = types.bool;
			};
			path = mkOption {
				default = pkgs.fetchurl { inherit url sha256; };
				type    = types.path;
			};
		};
	};
}
