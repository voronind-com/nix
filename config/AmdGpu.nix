{
	config,
	lib,
	...
}: let
	cfg = config.module.amd.gpu;
in {
	config = lib.mkIf cfg.enable {
		environment.variables.AMD_VULKAN_ICD = "RADV";
		boot.initrd.kernelModules = [
			"amdgpu"
		];
		services.xserver.videoDrivers = [
			"amdgpu"
		];
		hardware.graphics = {
			enable      = true;
			enable32Bit = true;
		};

		# AMDVLK was broken for me (huge stuttering). So keep it disabled, at least for now.
		# hardware.opengl.extraPackages = with pkgs; [
		#   amdvlk
		# ];
		# hardware.opengl.extraPackages32 = with pkgs; [
		#   driversi686Linux.amdvlk
		# ];
	};
}
