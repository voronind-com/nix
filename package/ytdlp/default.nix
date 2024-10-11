{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
}:
let
  version = "2024.05.27";
  hash = "sha256-rwVwteYBlqF4WhLn9I/Hy3tXRbC7mHDKL+btkN3YC0Y=";
in
stdenv.mkDerivation {
  name = "ytdlp";

  dontUnpack = true;

  # https://github.com/yt-dlp/yt-dlp
  src = fetchurl {
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
    sha256 = "${hash}";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/yt-dlp
    chmod +x $out/bin/yt-dlp
  '';

  meta = with lib; {
    description = "Youtube Downloader.";
    homepage = "https://github.com/yt-dlp/yt-dlp";
    license = licenses.unlicense;
    meta.platforms = platforms.all;
    mainProgram = "yt-dlp";
  };
}
