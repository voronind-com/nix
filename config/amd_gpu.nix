# Configuration specific for AMD GPUs.
{ config, lib, ... }:
let
  cfg = config.module.amd.gpu;
in
{
  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    environment.variables.AMD_VULKAN_ICD = "RADV";
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
