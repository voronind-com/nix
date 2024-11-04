# Use stable packages for Nix and Nixos-Rebuild.
{
	pkgsStable,
	...
}: {
	nixpkgs.overlays = [(final: prev: {
		nix           = pkgsStable.nix;
		nixos-rebuild = pkgsStable.nixos-rebuild;
	})];
}
