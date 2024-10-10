{ pkgs, ... }: with pkgs.python3Packages; buildPythonPackage {
	version = "1.0.0";
	pname   = "yandex-music-downloader";
	format  = "pyproject";

	propagatedBuildInputs = [
		setuptools
		setuptools-git
		requests
		eyed3
		browser-cookie3
	];

	src = pkgs.fetchFromGitHub {
		owner = "llistochek";
		repo  = "yandex-music-downloader";
		rev   = "08ea384869cbc31efb1e78b831e2356882219951";
		hash  = "sha256-WOFesD7HjskyqHaXZAPy3pgSPaEO+tOyQ+5MV3ZO7XU=";
	};

	meta.mainProgram = "yandex-music-downloader";
}
