# This module enables AMD compute support known as ROCM.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.amd.compute;
in
{
  config = lib.mkIf cfg.enable {
    hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
    nixpkgs.config.rocmSupport = true;
    systemd.tmpfiles.settings.rocm-hip."/opt/rocm/hip"."L+".argument = "${pkgs.rocmPackages.clr}";
  };
}
