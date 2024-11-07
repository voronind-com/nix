{ ... }: {
	home.nixos.enable = true;
	user = {
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		autoupdate.enable     = true;
		builder.client.enable = true;
		keyd.enable           = true;
		print.enable          = true;
		sway = {
			enable = true;
			extraConfig = ''
				output DSI-1 transform 90
			'';
		};
		kernel = {
			enable = true;
			latest = true;
		};
		hwmon = {
			file = "temp1_input";
			path = "/sys/devices/platform/coretemp.0/hwmon";
		};
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
}
