{ pkgs, lib, ... }: with lib; let
	url    = "https://i.imgur.com/DEawPwc.jpeg";
	sha256 = "1qzd1n3an5simjm9j87a41xdp7z2w7x723x8pbhv521m2wnpj34h";
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
