{
  fetchFromGitHub,
  buildNpmPackage,
  fetchpatch,
  ...
}:
buildNpmPackage rec {
  version = "4.9.96";

  pname = "dark-reader";

  src = fetchFromGitHub {
    # owner = "darkreader";
    owner = "voronind-com";
    repo = "darkreader";
    # rev = "v${version}";
    rev = "ddd532cb92594d2f4a73480dae6e6c024657dfe2";
    hash = "sha256-mONoHe/Aphm6T5UcucxlzMLDaNnqIKd35uCAVoYlJ8s=";
  };

  npmDepsHash = "sha256-e41PXGgoQkVSHQj6kElqXPhzc6irnr09ltBAPmcUjik=";

  # patches = [
  #   (fetchpatch {
  #     url = "https://github.com/darkreader/darkreader/pull/12920.diff";
  #     hash = "sha256-3r54SliCgxihGXzZDRklB0vB3bk9rc1H31PojAYn2Ic=";
  #   })
  # ];

  installPhase = ''
    mkdir -p $out
    cp build/release/darkreader-firefox.xpi $out/latest.xpi
  '';
}
