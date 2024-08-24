{ ... }: {
	imports = [
		./Backup.nix
		./Container.nix
		./Filesystem.nix
		./Network.nix
		./Photoprocess.nix
		./YaMusicDownload.nix
	];

	home.nixos.enable    = true;
	user.voronind.enable = true;

	module = {
		builder.server.enable = true;
		desktop.sway.enable   = true;
		amd = {
			cpu = {
				enable = true;
				powersave.enable = false;
			};
			gpu.enable = true;
		};
		ftpd = {
			enable  = true;
			storage = "/storage/hot/ftp";
		};
		package = {
			common.enable  = true;
			core.enable    = true;
			desktop.enable = true;
		};
	};

	setting = {
		cpu.hwmon = {
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
			file = "temp1_input";
		};
	};
}
