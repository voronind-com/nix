{ ... }: {
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.allowInsecurePredicate = x: true; # HACK: Nix is fucking annoying.
	nix.settings = {
		auto-optimise-store = true;
		keep-derivations = true;
		keep-outputs     = true;
		min-free = 1 * 1000 * 1000 * 1000;
		experimental-features = [
			"flakes"
			"nix-command"
		];
	};
}
