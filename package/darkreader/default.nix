{
  fetchFromGitHub,
  buildNpmPackage,
  fetchpatch,
  fetchNpmDeps,
  ...
}:
buildNpmPackage rec {
  # version = "4.9.96";
  version = "c700f9e03440131d46c6506eca79499a65fb1bd8";

  pname = "dark-reader";

  src = fetchFromGitHub {
    owner = "nenikitov";
    repo = "darkreader";
    # rev = "v${version}";
    # rev = "c700f9e03440131d46c6506eca79499a65fb1bd8";
    rev = version;
    hash = "sha256-oscW2V6GBBAa6/1uwhU4nimu2kMnd429p9rCEYZC7ZM=";
  };

  npmDepsHash = "sha256-e41PXGgoQkVSHQj6kElqXPhzc6irnr09ltBAPmcUjik=";
  # npmDepsHash = "sha256-dSuCL8GZXiksqVQ+TypzOdAROn3q30ExaGCJu72GLyY=";
  # npmDeps = fetchNpmDeps {
  #   inherit src;
  #   name = "${pname}-${version}-npm-deps";
  #   hash = npmDepsHash;
  # };

  # patches = [
  #   (fetchpatch {
  #     url = "https://github.com/darkreader/darkreader/pull/12920.patch";
  #     hash = "sha256-XNYSrccQAAT4nd/uu/cunlq4WfoL7xKqWUUlTBqwuU8=";
  #   })
  # ];

  installPhase = ''
    mkdir -p $out
    cp build/release/darkreader-firefox.xpi $out/latest.xpi
  '';
}
