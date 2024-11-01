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
    owner = "darkreader";
    repo = "darkreader";
    rev = "v${version}";
    hash = "sha256-2AYIFVTTMns1u0jKk3XeFuYdC1MfG9aOCMjAfZtlXuI=";
  };

  npmDepsHash = "sha256-dSuCL8GZXiksqVQ+TypzOdAROn3q30ExaGCJu72GLyY=";

  patches = [
    (fetchpatch {
      url = "https://github.com/darkreader/darkreader/pull/12920.diff";
      hash = "sha256-3r54SliCgxihGXzZDRklB0vB3bk9rc1H31PojAYn2Ic=";
    })
  ];

  installPhase = ''
    mkdir -p $out
    cp build/release/darkreader-firefox.xpi $out/latest.xpi
  '';
}
