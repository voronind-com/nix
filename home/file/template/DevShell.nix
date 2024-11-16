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
			default = pkgs.mkShell rec {
				nativeBuildInputs = with pkgs; [ ];
				buildInputs = with pkgs; [ ];

				LD_LIBRARY_PATH   = "${lib.makeLibraryPath buildInputs}";
				SOURCE_DATE_EPOCH = "${toString self.lastModified}";
			};
		};
	};
}
