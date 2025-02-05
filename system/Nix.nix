{ inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecurePredicate = x: true; # HACK: Nix is fucking annoying.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.settings = {
    auto-optimise-store = true;
    keep-derivations = false;
    keep-outputs = false;
    min-free = 10 * 1000 * 1000 * 1000;
    substituters = [ "https://nixos-cache-proxy.cofob.dev" ];
    experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
  };
}
