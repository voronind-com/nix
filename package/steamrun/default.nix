{
	__findFile,
	inputs,
	pkgs,
	...
}: {
	pkg = pkgs.callPackage "${inputs.nixpkgs}/pkgs/by-name/st/steam/package.nix" {
		extraLibraries = pkgs: [
			(pkgs.callPackage <package/openssl100> {})
		];
	};
}
