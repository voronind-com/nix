{ ... }: {
	imports = [
		./Backup.nix
		./Container.nix
		./Filesystem.nix
		./Network.nix
		./Photoprocess.nix
		./YaMusicDownload.nix
	];

	home.nixos.enable = true;
	user = {
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		builder.server.enable = true;
		desktop.sway.enable   = true;
		kernel.enable         = true;
		amd = {
			cpu.enable = true;
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
		zapret = {
			enable = true;
			params = "--dpi-desync=fake,split2 --dpi-desync-fooling=datanoack";
			whitelist = ''
				youtube.com
				googlevideo.com
				ytimg.com
				youtu.be
				rutracker.org
				rutracker.cc
				rutrk.org
			'';
		};
	};

	setting = {
		cpu.hwmon = {
			path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon";
			file = "temp1_input";
		};
	};
}
