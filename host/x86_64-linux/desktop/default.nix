{ ... }: {
	imports = [
		./Filesystem.nix
	];

	home.nixos.enable    = true;
	user.voronind.enable = true;

	module = {
		autoupdate.enable     = true;
		builder.client.enable = true;
		desktop.sway.enable   = true;
		ollama.enable         = true;
		print.enable          = true;
		virtmanager.enable    = true;
		amd = {
			compute.enable = true;
			cpu.enable     = true;
			gpu.enable     = true;
		};
		docker = {
			enable    = true;
			autostart = false;
			rootless  = false;
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
