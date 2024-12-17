{
	inputs,
	pkgs,
	...
}: {
	pkg = pkgs.callPackage "${inputs.nixpkgs}/pkgs/by-name/st/steam/package.nix" {
		extraLibraries = pkgs: with pkgs; [
			openssl_1_1
		];
	};
}
