{ __findFile, pkgs, ... }:
{
  pkg =
    with pkgs;
    (steam.override {
      extraLibraries = _: [
        (callPackage <package/openssl100> { })
        curlWithGnuTls
      ];
    }).run;
}
