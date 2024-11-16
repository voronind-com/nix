{ ... }: {
	home.nixos.enable = true;
	user = {
		root     = true;
		voronind = true;
	};

	module = {
		builder.client.enable = true;
		package.extra = true;
		print.enable  = true;
		purpose = {
			creativity = true;
			laptop     = true;
			work       = true;
		};
		sway.extraConfig = ''
			output DSI-1 transform 90
			input * map_to_output DSI-1
		'';
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
