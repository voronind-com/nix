{ ... }: {
	home.nixos.enable = true;
	user = {
		dasha = true;
		root  = true;
	};

	module = {
		amd.gpu.enable        = true;
		builder.client.enable = true;
		display.primary       = "DP-1";
		package.extra         = true;
		print.enable          = true;
		purpose = {
			creativity = true;
			desktop    = true;
			disown     = true;
			gaming     = true;
			work       = true;
		};
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/platform/coretemp.0/hwmon";
		};
		intel.cpu = {
			enable    = true;
			powersave = true;
		};
	};
}
