{
  __findFile,
  config,
  inputs,
  pkgs,
  pkgsMaster,
  ...
}:
{
  disabledModules = [ "services/web-apps/invidious.nix" ];
  imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/web-apps/invidious.nix" ];

  services.invidious = {
    enable = true;
    domain = "yt.voronind.com";
    package = pkgsMaster.invidious;
    address = "::1";
    port = 3001;
    nginx.enable = false;
    database = {
      createLocally = true;
      # passwordFile  = "${pkgs.writeText "InvidiousDbPassword" "invidious"}";
    };
    settings = {
      admins = [ "root" ];
      captcha_enabled = false;
      check_tables = true;
      external_port = 443;
      https_only = true;
      registration_enabled = false;
    };
  };
}
