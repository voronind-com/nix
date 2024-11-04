{ ... }: {
	nixpkgs.config.allowUnfree = true;
	nix.settings = {
		auto-optimise-store = true;
		keep-derivations = true;
		keep-outputs     = true;
		min-free = 1 * 1000 * 1000 * 1000;
		experimental-features = [
			"flakes"
			"nix-command "
		];
	};
}
