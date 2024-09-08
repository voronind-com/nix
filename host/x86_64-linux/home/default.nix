{ config, ... }: {
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
		keyd.enable           = true;
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
			params = "--dpi-desync=fake,disorder2 --dpi-desync-ttl=1 --dpi-desync-autottl=2";
			autolist = "${config.container.module.frkn.storage}/Autolist.txt";
			whitelist = ''
				youtube.com
				googlevideo.com
				ytimg.com
				youtu.be
				rutracker.org
				rutracker.cc
				rutrk.org
				t-ru.org
				medium.com
				quora.com
				quoracdn.net
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
