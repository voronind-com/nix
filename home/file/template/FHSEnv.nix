{
	description = "";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs } @inputs: let
		lib    = nixpkgs.lib;
		pkgs   = nixpkgs.legacyPackages.${system};
		system = "x86_64-linux";
	in {
		devShells.${system} = {
			default = with pkgs; (buildFHSEnv {
				name = "FHSEnv";
				targetPkgs = pkgs: with pkgs; [ ];
			}).env;
		};
	};
}
