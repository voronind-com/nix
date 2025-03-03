{ __findFile, pkgs, ... }:
{
  pkg =
    with pkgs;
    (steam.override {
      extraLibraries = _: [
        (callPackage <package/openssl_100> { })
        curlWithGnuTls
      ];
    }).run;
}
