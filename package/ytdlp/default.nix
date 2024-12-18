{
  autoPatchelfHook,
  fetchurl,
  lib,
  stdenv,
}:
let
  hash = "sha256-rwVwteYBlqF4WhLn9I/Hy3tXRbC7mHDKL+btkN3YC0Y=";
  version = "2024.05.27";
in
stdenv.mkDerivation {
  dontUnpack = true;
  name = "ytdlp";
  src = fetchurl {
    sha256 = "${hash}";
    url = "https://github.com/yt-dlp/yt-dlp/releases/download/${version}/yt-dlp_linux";
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
    mainProgram = "yt-dlp";
    meta.platforms = platforms.all;
  };
}
