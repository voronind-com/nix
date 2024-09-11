{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/ejuqZRb.jpeg";
	sha256 = "14qpz0zygiraksa7p96522gg2s9q10iv3kixi4s7nqy6fgjvdzvm";
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
