# Apple San Francisco and New York fonts.
# They are not available in Nixpkgs repo, so this script
# downloads the fonts from Apple website and adds them to Nix store.
{ lib, stdenv, fetchurl, p7zip }: let
	pro = fetchurl {
		url    = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
		sha256 = "sha256-B8xljBAqOoRFXvSOkOKDDWeYUebtMmQLJ8lF05iFnXk=";
	};

	compact = fetchurl {
		url    = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
		sha256 = "sha256-L4oLQ34Epw1/wLehU9sXQwUe/LaeKjHRxQAF6u2pfTo=";
	};

	mono = fetchurl {
		url    = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
		sha256 = "sha256-Uarx1TKO7g5yVBXAx6Yki065rz/wRuYiHPzzi6cTTl8=";
	};

	ny = fetchurl {
		url    = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
		sha256 = "sha256-yYyqkox2x9nQ842laXCqA3UwOpUGyIfUuprX975OsLA=";
	};
in stdenv.mkDerivation {
	name = "applefont";

	dontUnpack = true;

	nativeBuildInputs = [ p7zip ];

	installPhase = let
		unpackFont = dmg: dir: pkg: ''
			7z x '${dmg}'
			pushd '${dir}'
			7z x '${pkg}'
			7z x 'Payload~'
			cp Library/Fonts/* $TMPDIR
			popd
		'';
	in ''
		${unpackFont pro     "SFProFonts"     "SF Pro Fonts.pkg"}
		${unpackFont mono    "SFMonoFonts"    "SF Mono Fonts.pkg"}
		${unpackFont compact "SFCompactFonts" "SF Compact Fonts.pkg"}
		${unpackFont ny      "NYFonts"        "NY Fonts.pkg"}

		mkdir -p $out/usr/share/fonts/{TTF,OTF}
		mv $TMPDIR/*.otf $out/usr/share/fonts/OTF
		mv $TMPDIR/*.ttf $out/usr/share/fonts/TTF
	'';

	meta = with lib; {
		description    = "Apple San Francisco, New York fonts.";
		homepage       = "https://developer.apple.com/fonts";
		license        = licenses.unfree;
		meta.platforms = platforms.all;
	};
}
