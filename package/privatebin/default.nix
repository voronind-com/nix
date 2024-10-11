{
  php,
  pkgs,
  util,
  config,
  ...
}@args:
let
  cfg = pkgs.writeText "PrivateBinConfig" (import ./Config.nix args).text;
in
php.buildComposerProject (finalAttrs: {
  pname = "PrivateBin";
  version = "1.7.4";

  src = pkgs.fetchFromGitHub {
    owner = "PrivateBin";
    repo = "PrivateBin";
    rev = finalAttrs.version;
    hash = "sha256-RFP6rhzfBzTmqs4eJXv7LqdniWoeBJpQQ6fLdoGd5Fk=";
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
