# Configuration specific for AMD CPUs.
{ config, lib, ... }:
let
  cfg = config.module.amd.cpu;

  # Powersave configuration (CPU boost toggle).
  controlFile = "/sys/devices/system/cpu/cpufreq/boost";
  disableCmd = "1";
  enableCmd = "0";
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        boot.kernelModules = [ "kvm-amd" ];
        hardware.cpu.amd.updateMicrocode = true;
      }
      (lib.mkIf cfg.powersave {
        module.powersave = {
          enable = true;
          cpu.boost = { inherit controlFile disableCmd enableCmd; };
        };
      })
    ]
  );
}
