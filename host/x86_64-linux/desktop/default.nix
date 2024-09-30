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
		virtmanager.enable    = true;
		amd = {
			compute.enable = true;
			gpu.enable     = true;
			cpu = {
				enable    = true;
				powersave = true;
			};
		};
		desktop.sway = {
			enable = true;
			extraConfig = ''
				workspace 1 output "ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165"
			'';
		};
		docker = {
			enable    = true;
			autostart = false;
			rootless  = false;
		};
		kernel = {
			enable = true;
			latest = true;
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
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
			file = "temp1_input";
		};
	};
}
