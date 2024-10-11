{
  description = "Rust shell env.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      devShell.${system} = pkgs.mkShell rec {
        nativeBuildInputs = with pkgs; [
          cargo
          rustc
          rust-analyzer
          rustfmt

          cmake
          pkg-config
          fontconfig
        ];
        buildInputs = with pkgs; [
          libxkbcommon
          wayland
          libGL
          xorg.libX11
          xorg.libXrandr
          xorg.libXinerama
          xorg.libXcursor
          xorg.libXi
        ];
        LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
        SOURCE_DATE_EPOCH = "${toString self.lastModified}";
      };
    };
}
