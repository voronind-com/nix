{ lib, ... }:
{
  options.module.amd.cpu = {
    enable = lib.mkEnableOption "the AMD Cpu support.";
    powersave = lib.mkEnableOption "the AMD Cpu powersave.";
  };
}
