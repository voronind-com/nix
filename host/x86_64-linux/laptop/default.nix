{ ... }: {
	imports = [
		./Filesystem.nix
	];

	home.nixos.enable = true;
	user = {
		dasha.enable    = true;
		root.enable     = true;
		voronind.enable = true;
	};

	module = {
		autoupdate.enable     = true;
		builder.client.enable = true;
		desktop.sway.enable   = true;
		print.enable          = true;
		strongswan.enable     = true;
		tablet.enable         = true;
		amd = {
			compute.enable = true;
			cpu.enable     = true;
			gpu.enable     = true;
		};
		package = {
			common.enable   = true;
			core.enable     = true;
			desktop.enable  = true;
			gaming.enable   = true;
			creative.enable = true;
			dev.enable      = true;
		};
	};
}
