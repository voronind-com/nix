{ ... }: {
	home.nixos.enable = true;
	user = {
		dasha.enable = true;
		root.enable  = true;
	};

	module = {
		amd.gpu.enable        = true;
		autoupdate.enable     = true;
		builder.client.enable = true;
		desktop.sway.enable   = true;
		kernel.enable         = true;
		keyd.enable           = true;
		print.enable          = true;
		strongswan.enable     = true;
		tablet.enable         = true;
		intel.cpu = {
			enable    = true;
			powersave = true;
		};
		package = {
			common.enable   = true;
			core.enable     = true;
			creative.enable = true;
			desktop.enable  = true;
			dev.enable      = true;
			extra.enable    = true;
			gaming.enable   = true;
		};
	};

	setting = {
		cpu.hwmon = {
			path = "/sys/devices/platform/coretemp.0/hwmon";
			file = "temp1_input";
		};
	};

}
