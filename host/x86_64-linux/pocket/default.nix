{ lib, ... }: {
	home.nixos.enable = true;
	user = {
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		builder.client.enable = true;
		keyd.enable           = true;
		print.enable          = true;
		sway = {
			enable = true;
			extraConfig = ''
				output DSI-1 transform 90
				input * map_to_output DSI-1
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
