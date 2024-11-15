{
	buildNpmPackage,
	fetchFromGitHub,
	fetchpatch,
	...
}: buildNpmPackage rec {
	version     = "4.9.96";
	pname       = "dark-reader";
	npmDepsHash = "sha256-dSuCL8GZXiksqVQ+TypzOdAROn3q30ExaGCJu72GLyY=";
	src = fetchFromGitHub {
		hash  = "sha256-2AYIFVTTMns1u0jKk3XeFuYdC1MfG9aOCMjAfZtlXuI=";
		owner = "darkreader";
		repo  = "darkreader";
		rev   = "v${version}";
	};
	patches = [
		(fetchpatch {
			url  = "https://github.com/darkreader/darkreader/compare/v${version}...voronind-com:darkreader:main.diff";
			hash = "sha256-OqS6aY7PHHZvj7a0x1RI+1IpZxYXsqSia2ZeVM3XRZk=";
		})
	];
	installPhase = ''
		mkdir -p $out
		cp build/release/darkreader-firefox.xpi $out/latest.xpi
	'';
}
