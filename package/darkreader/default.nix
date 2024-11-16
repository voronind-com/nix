{
	__findFile,
	buildNpmPackage,
	fetchFromGitHub,
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
		<patch/darkreader/Policy.patch>
	];
	installPhase = ''
		mkdir -p $out
		cp build/release/darkreader-firefox.xpi $out/latest.xpi
	'';
}
