{ config, lib, ... }:
let
  cfg = config.module.amd.cpu;

  controlFile = "/sys/devices/system/cpu/cpufreq/boost";
  disableCmd = "1";
  enableCmd = "0";
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        boot.kernelModules = [ "kvm-amd" ];
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      }
      (lib.mkIf cfg.powersave {
        module.powersave = {
          enable = true;
          cpu.boost = { inherit controlFile enableCmd disableCmd; };
        };
      })
    ]
  );
}
