{ pkgs, ... }:
with pkgs.python3Packages;
buildPythonPackage {
  format = "pyproject";
  meta.mainProgram = "yandex-music-downloader";
  pname = "yandex-music-downloader";
  version = "1.0.0";
  propagatedBuildInputs = [
    browser-cookie3
    eyed3
    requests
    setuptools
    setuptools-git
  ];
  src = pkgs.fetchFromGitHub {
    hash = "sha256-WOFesD7HjskyqHaXZAPy3pgSPaEO+tOyQ+5MV3ZO7XU=";
    owner = "llistochek";
    repo = "yandex-music-downloader";
    rev = "08ea384869cbc31efb1e78b831e2356882219951";
  };
}
