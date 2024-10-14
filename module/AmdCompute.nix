{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.amd.compute;
in
{
  options = {
    module.amd.compute.enable = mkEnableOption "Enable AMD Rocm support i.e. for Blender.";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.rocmSupport = true;
    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };
}
