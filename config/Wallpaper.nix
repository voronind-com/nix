{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/0hghmnl.png";
	sha256 = "0l963jwb40xx7prnr58yfj5lvqmqw9nifn970dhqvzlcbfq17nbp";
	forceContrastText = true;
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
