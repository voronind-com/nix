{
	__findFile,
	config,
	pkgs,
	util,
	...
} @args: {
	# SEE: https://github.com/jtheoof/swappy/issues/131
	nixpkgs.overlays = [(final: prev: {
		swappy = prev.swappy.overrideAttrs (old: {
			patches = (old.patches or [ ]) ++ [
				(import <patch/swappy/DefaultColor.nix> args).file
			];
		});
	})];
}
