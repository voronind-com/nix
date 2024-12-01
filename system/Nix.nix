{ ... }: {
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.permittedInsecurePackages = [
		"dotnet-runtime-6.0.36" # HACK: I hate Nix for this.
		"dotnet-sdk-wrapped-6.0.428"
		"dotnet-sdk-6.0.428"
	];
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
