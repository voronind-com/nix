# SRC: https://git.azahi.cc/nixfiles/tree/packages/openssl_1_0_0.nix
{
  autoPatchelfHook,
  fetchurl,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "openssl";
  version = "1.0.0";

  sourceRoot = "x86_64";

  dontBuild = true;
  dontConfigure = true;
  dontPatch = true;

  src = fetchurl {
    url = "https://downloads.dotslashplay.it/resources/openssl/openssl_${finalAttrs.version}.tar.xz";
    hash = "sha256-B8/FdkheAwrAtscn6dvUuen1slfRglM/kJb2xGm7uvA=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall

    install -Dm555 -t $out/lib libcrypto.so.1.0.0
    install -Dm555 -t $out/lib libssl.so.1.0.0

    runHook postInstall
  '';
})
