# DPI-specific configuration.
# For now there's only configuration to bypass it.
# Technically in the future I might setup DPI at home
# for the ad blocking or security/privacy reasons.
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
  # Use zapret module from nixpkgs master branch.
  disabledModules = [ "services/networking/zapret.nix" ];
  imports = [ "${inputs.nixpkgs-master}/nixos/modules/services/networking/zapret.nix" ];

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
