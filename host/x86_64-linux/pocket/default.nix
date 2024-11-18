# GPD pocket-like machine.
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
			gaming     = true;
			laptop     = true;
			work       = true;
		};
		display = {
			primary = "DSI-1";
			rotate = {
				tty   = 90;
				DSI-1 = 90;
			};
		};
		sway.extraConfig = [
			"input type:touch map_to_output DSI-1"
		];
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
