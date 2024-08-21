{ php, pkgs, util, config, ... } @args: let
	cfg = pkgs.writeText "PrivateBinConfig" (import ./Config.nix args).text;
in php.buildComposerProject (finalAttrs:  {
	pname   = "PrivateBin";
	version = "1.7.3";

	src = pkgs.fetchFromGitHub {
		owner = "PrivateBin";
		repo  = "PrivateBin";
		rev   = finalAttrs.version;
		hash  = "sha256-9aTpLixvvyy3xTk8QQFj4rI6gFtElO4naPgTARtpo1k=";
	};

	vendorHash = "sha256-JGuO8kXLLXqq76EccdNSoHwYO5OuJT3Au1O2O2szAHI=";

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
