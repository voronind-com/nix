{
	pkgs,
	...
}: {
	# hardware.cpu.amd.ryzen-smu.enable = true;

	environment.systemPackages = with pkgs; [
		# SRC: https://github.com/FlyGoat/RyzenAdj
		# ./ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90
		# ryzenAdj --info
		ryzenadj

		# SRC: https://github.com/nbfc-linux/nbfc-linux
		nbfc-linux
	];

	systemd.services.radj = {
		enable = true;
		description = "Ryzen Adj temperature limiter.";
		serviceConfig.Type = "simple";
		wantedBy = [ "multi-user.target" ];
		path = with pkgs; [
			coreutils
			ryzenadj
		];
		script = ''
			while true; do
				ryzenadj --tctl-temp=45
				sleep 60
			done
		'';
	};
}
