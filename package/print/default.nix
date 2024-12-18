# SEE: https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/misc/drivers/pantum-driver/default.nix
{
  fetchurl,
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "pantum-driver";
  dontUnpack = true;
  version = "1.1.106";
  src = fetchurl {
    hash = "sha256-IflzEM2kqqMqOQWZ5Eu906dEa85h+NFRmoR7y7WPX7Q=";
    url = "https://cloud.voronind.com/s/k6Ea6QsrsKcAeNg/download/Pantum%20Ubuntu%20Driver%20V1_1_106.zip";
  };
  buildInputs = with pkgs; [
    cups
    libjpeg8
    libusb1
  ];
  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    dpkg
    unzip
  ];
  installPhase = ''
    unzip $src
    pushd Pantum\ Ubuntu\ Driver\ V1.1.106/

    dpkg-deb -x ./Resources/pantum_${version}-1_amd64.deb .

    mkdir -p $out $out/lib
    cp -r etc $out/
    cp -r usr/lib/cups $out/lib/
    cp -r usr/local/lib/* $out/lib/
    cp -r usr/share $out/
    cp Resources/locale/en_US.UTF-8/* $out/share/doc/pantum/
  '';
  # + ''
  #   cp -r opt/pantum/* $out/
  #   ln -s $out/lib/libqpdf.so* $out/lib/libqpdf.so
  #   ln -s $out/lib/libqpdf.so $out/lib/libqpdf.so.21
  # '';
}
