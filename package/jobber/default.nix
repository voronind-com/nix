{
	poetry2nix,
	pkgs,
	...
}: let
	inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication;
in
	mkPoetryApplication { projectDir = ./project; }
