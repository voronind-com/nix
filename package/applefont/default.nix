# Apple San Francisco and New York fonts.
# They are not available in Nixpkgs repo, so this script
# downloads the fonts from Apple website and adds them to Nix store.
{
  fetchurl,
  lib,
  p7zip,
  stdenv,
}:
let
  pro = fetchurl {
    sha256 = "1krvzxz7kal6y0l5cx9svmgikqdj5v0fl5vnfjig0z4nwp903ir1";
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
  };
  compact = fetchurl {
    sha256 = "0ncybkrzqazw13azy2s30ss7ml5pxaia6hbmqq9wn7xhlhrxlniy";
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
  };
  mono = fetchurl {
    sha256 = "0ibrk9fvbq52f5qnv1a8xlsazd3x3jnwwhpn2gwhdkdawdw0njkd";
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
  };
  ny = fetchurl {
    sha256 = "1x7qi3dqwq1p4l3md31cd93mcds3ba7rgsmpz0kg7h3caasfsbhw";
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
  };
in
stdenv.mkDerivation {
  name = "applefont";
  dontUnpack = true;
  nativeBuildInputs = [ p7zip ];
  installPhase =
    let
      unpackFont = dmg: dir: pkg: ''
        7z x '${dmg}'
        pushd '${dir}'
        7z x '${pkg}'
        7z x 'Payload~'
        cp Library/Fonts/* $TMPDIR
        popd
      '';
    in
    ''
      ${unpackFont pro "SFProFonts" "SF Pro Fonts.pkg"}
      ${unpackFont mono "SFMonoFonts" "SF Mono Fonts.pkg"}
      ${unpackFont compact "SFCompactFonts" "SF Compact Fonts.pkg"}
      ${unpackFont ny "NYFonts" "NY Fonts.pkg"}

      mkdir -p $out/usr/share/fonts/{TTF,OTF}
      mv $TMPDIR/*.otf $out/usr/share/fonts/OTF
      mv $TMPDIR/*.ttf $out/usr/share/fonts/TTF
    '';

  meta = with lib; {
    description = "Apple San Francisco, New York fonts.";
    homepage = "https://developer.apple.com/fonts";
    license = licenses.mit;
    meta.platforms = platforms.all;
  };
}
