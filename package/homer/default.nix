{
  stdenv,
  pkgs,
  config,
  ...
}@args:
let
  cfg = (import ./Config.nix args).file;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "Homer";
  version = "24.05.1";

  src = pkgs.fetchurl {
    url = "https://github.com/bastienwirtz/homer/releases/download/v${finalAttrs.version}/homer.zip";
    sha256 = "sha256-Ji/7BSKCnnhj4NIdGngTHcGRRbx9UWrx48bBsKkEj34=";
  };

  nativeBuildInputs = with pkgs; [ unzip ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/assets
    pushd $out
    unzip $src
    cp ${cfg} $out/assets/config.yml

    runHook postInstall
  '';
})
