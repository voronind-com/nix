{
	description = "Rust shell env.";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs } @inputs: let
			lib    = nixpkgs.lib;
			pkgs   = nixpkgs.legacyPackages.${system};
			system = "x86_64-linux";
		in {
			devShell.${system} = pkgs.mkShell rec {
				nativeBuildInputs = with pkgs; [
					cargo
					cmake
					fontconfig
					pkg-config
					rust-analyzer
					rustc
					rustfmt
				];
				buildInputs = with pkgs; [
					libGL
					libxkbcommon
					wayland
					xorg.libX11
					xorg.libXcursor
					xorg.libXi
					xorg.libXinerama
					xorg.libXrandr
				];
				LD_LIBRARY_PATH   = "${lib.makeLibraryPath buildInputs}";
				SOURCE_DATE_EPOCH = "${toString self.lastModified}";
			};
		};
}
