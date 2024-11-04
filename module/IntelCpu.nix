# Intel CPU specific configuration.
{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.intel.cpu;

	controlFile = "/sys/devices/system/cpu/intel_pstate/no_turbo";
	disableCmd  = "0";
	enableCmd   = "1";
in {
	options.module.intel.cpu = {
		enable    = lib.mkEnableOption "the support for Intel CPUs";
		powersave = lib.mkEnableOption "the Intel CPU powersave.";
	};

	config = lib.mkIf cfg.enable (lib.mkMerge [
		{
			boot.kernelModules = [
				"kvm-intel"
			];
		}
		(lib.mkIf cfg.powersave {
			module.powersave = {
				enable = true;
				cpu.boost = {
					inherit controlFile enableCmd disableCmd;
				};
			};
		})
	]);
}
