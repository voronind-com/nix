{
  __findFile,
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  pkgs,
  ...
}:
buildNpmPackage rec {
  version = "4.9.99";
  pname = "dark-reader";
  npmDepsHash = "sha256-m41HkwgbeRRmxJALQFJl/grYjjIqFOc47ltaesob1FA=";
  env.ESBUILD_BINARY_PATH = lib.getExe pkgs.esbuild;
  patches = [ <patch/darkreader/Policy.patch> ];
  src = fetchFromGitHub {
    hash = "sha256-K375/4qOyE1Tp/T5V5uCGcNd1IVVbT1Pjdnq/8oRHj0=";
    owner = "darkreader";
    repo = "darkreader";
    rev = "v${version}";
  };
  installPhase = ''
    mkdir -p $out
    cp build/release/darkreader-firefox.xpi $out/latest.xpi
  '';
}
