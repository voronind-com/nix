{
  fetchFromGitHub,
  buildNpmPackage,
  fetchpatch,
  fetchNpmDeps,
  ...
}:
buildNpmPackage rec {
  # version = "4.9.96";
  version = "af57bb1370bd449a7b294759bf2ce353f358ace8";

  pname = "dark-reader";

  src = fetchFromGitHub {
    owner = "nenikitov";
    repo = "darkreader";
    # rev = "v${version}";
    rev = version;
    hash = "sha256-cX/kwG6lOjNTsf6x86jVWmYLvB6qIeK/B0s2aT08oJU=";
  };

  npmDepsHash = "sha256-+FPYo5ev/ccp28vX6As/KbFtOtf9bQfhA0b1ufHVmTo=";
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
