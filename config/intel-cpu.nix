# Intel CPU specific configuration.
{ config, lib, ... }:
let
  cfg = config.module.intel.cpu;

  # CPU powersave by toggling boost only when needed.
  controlFile = "/sys/devices/system/cpu/intel_pstate/no_turbo";
  disableCmd = "0";
  enableCmd = "1";
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      { boot.kernelModules = [ "kvm-intel" ]; }
      (lib.mkIf cfg.powersave {
        module.powersave = {
          enable = true;
          cpu.boost = { inherit controlFile enableCmd disableCmd; };
        };
      })
    ]
  );
}
