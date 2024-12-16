# SRC: https://github.com/matega/win-max-2-fan-control
{
	autoPatchelfHook,
	fetchFromGitHub,
	lib,
	stdenv,
}: stdenv.mkDerivation {
	# dontUnpack = true;
	name = "wm2fc";
	src = fetchFromGitHub {
		hash  = "sha256-rU0n+4glTWHWjbvbc7Se0O53g1mVDwBP5SkH4ftwNWk=";
		owner = "matega";
		repo  = "win-max-2-fan-control";
		rev   = "a9e65011e0b45d0a76fc5307ad2b7b585410dece";
	};
	installPhase = ''
		runHook preInstall
		install -Dm755 dist/Debug/GNU-Linux/winmax2fancontrol $out/bin/wm2fc
		runHook postInstall
	'';
	meta = with lib; {
		description    = "GPD Win Max 2 Fan Control PoC";
		license        = licenses.gpl3;
		mainProgram    = "wm2fc";
		meta.platforms = platforms.all;
	};
}

