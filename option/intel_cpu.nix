{ lib, ... }:
{
  options.module.intel.cpu = {
    enable = lib.mkEnableOption "the support for Intel CPUs.";
    powersave = lib.mkEnableOption "the Intel CPU powersave.";
  };
}
