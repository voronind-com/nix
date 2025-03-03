{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.module.dpi.bypass;
in
{
  disabledModules = [ "services/networking/zapret.nix" ];
  imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/networking/zapret.nix" ];

  config = lib.mkIf cfg.enable {
    services.zapret = {
      enable = true;
      inherit (cfg)
        package
        params
        whitelist
        blacklist
        qnum
        configureFirewall
        httpSupport
        httpMode
        udpSupport
        udpPorts
        ;
    };
  };
}
