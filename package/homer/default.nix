{
	config,
	pkgs,
	stdenv,
	...
} @args: let
	cfg = (import ./Config.nix args).file;
in stdenv.mkDerivation (finalAttrs: {
	dontUnpack = true;
	pname      = "Homer";
	version    = "24.05.1";
	src = pkgs.fetchurl {
		sha256 = "sha256-Ji/7BSKCnnhj4NIdGngTHcGRRbx9UWrx48bBsKkEj34=";
		url    = "https://github.com/bastienwirtz/homer/releases/download/v${finalAttrs.version}/homer.zip";
	};
	nativeBuildInputs = with pkgs; [
		unzip
	];
	installPhase = ''
		runHook preInstall

		mkdir -p $out/assets
		pushd $out
		unzip $src
		cp ${cfg} $out/assets/config.yml

		runHook postInstall
	'';
})
