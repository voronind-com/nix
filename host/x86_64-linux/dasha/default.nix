{ ... }: {
	home.nixos.enable = true;
	user = {
		dasha = true;
		root  = true;
	};

	module = {
		builder.client.enable = true;
		amd.gpu.enable = true;
		package.extra  = true;
		print.enable   = true;
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
