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
    nixpkgs.config.rocmSupport = true;
    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };
}
