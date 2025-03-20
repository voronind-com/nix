{ __findFile, pkgs, ... }:
{
  pkg =
    with pkgs;
    (steam.override {
      extraLibraries = _: [
        (callPackage <package/openssl-100> { })
        curlWithGnuTls
      ];
    }).run;
}
