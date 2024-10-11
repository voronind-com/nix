{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system} = {
        default =
          with pkgs;
          (buildFHSEnv {
            name = "FHSEnv";
            targetPkgs = pkgs: with pkgs; [ ];
          }).env;
      };
    };
}
