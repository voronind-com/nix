{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.amd.gpu;
in
{
  options = {
    module.amd.gpu.enable = mkEnableOption "Enable AMD Gpu support.";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    environment.variables.AMD_VULKAN_ICD = "RADV";

    # AMDVLK was broken for me (huge stuttering). So keep it disabled, at least for now.
    # hardware.opengl.extraPackages = with pkgs; [
    #   amdvlk
    # ];
    # hardware.opengl.extraPackages32 = with pkgs; [
    #   driversi686Linux.amdvlk
    # ];
  };
}
