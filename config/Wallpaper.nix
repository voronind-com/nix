{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/Q8ZTZCH.png";
	sha256 = "1h03nybqcmxgqrngkhv0896ijf4zfbb8z9kw5ybl5sc5wwjfdg8w";
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
