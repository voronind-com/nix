{ ... }: {
	home.nixos.enable = true;
	user = {
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		builder.server.enable = true;
		sway.enable           = true;
		kernel.enable         = true;
		keyd.enable           = true;
		amd = {
			cpu.enable = true;
			gpu.enable = true;
		};
		ftpd = {
			enable  = true;
			storage = "/storage/hot/ftp";
		};
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
		};
		package = {
			common.enable  = true;
			core.enable    = true;
			desktop.enable = true;
		};
	};
}
