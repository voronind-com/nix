{
  config,
  pkgs,
  stdenv,
  ...
}@args:
let
  cfg = (import ./config.nix args).file;
  css = ./custom.css;
in
stdenv.mkDerivation (finalAttrs: {
  dontUnpack = true;
  pname = "Homer";
  version = "24.05.1";
  nativeBuildInputs = with pkgs; [ unzip ];
  src = pkgs.fetchurl {
    sha256 = "sha256-Ji/7BSKCnnhj4NIdGngTHcGRRbx9UWrx48bBsKkEj34=";
    url = "https://github.com/bastienwirtz/homer/releases/download/v${finalAttrs.version}/homer.zip";
  };
  installPhase = ''
    runHook preInstall

    mkdir -p $out/assets
    pushd $out
    unzip $src
    cp ${cfg} $out/assets/config.yml
    cp ${css} $out/assets/custom.css

    runHook postInstall
  '';
})
