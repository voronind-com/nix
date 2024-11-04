{
	config,
	php,
	pkgs,
	...
} @args: let
	cfg = (import ./Config.nix args).file;
in php.buildComposerProject (finalAttrs: {
	pname      = "PrivateBin";
	vendorHash = "sha256-JGuO8kXLLXqq76EccdNSoHwYO5OuJT3Au1O2O2szAHI=";
	version    = "1.7.4";
	src = pkgs.fetchFromGitHub {
		hash  = "sha256-RFP6rhzfBzTmqs4eJXv7LqdniWoeBJpQQ6fLdoGd5Fk=";
		owner = "PrivateBin";
		repo  = "PrivateBin";
		rev   = finalAttrs.version;
	};
	installPhase = ''
		runHook preInstall

		mv $out/share/php/PrivateBin/* $out
		rm -r $out/share

		cp ${cfg} $out/cfg/conf.php

		touch $out/.env
		pushd $out

		runHook postInstall
	'';
	postFixup = ''
		substituteInPlace $out/index.php --replace-fail \
			"define('PATH', ''')" \
			"define('PATH', '$out/')"
	'';
})
