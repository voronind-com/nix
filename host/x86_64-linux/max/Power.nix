{
	__findFile,
	pkgs,
	...
}: let
	tbase = 45;
	wm2fc = pkgs.callPackage <package/wm2fc> {};
in {
	# hardware.cpu.amd.ryzen-smu.enable = true;

	environment.systemPackages = with pkgs; [
		# SRC: https://github.com/FlyGoat/RyzenAdj
		# ./ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90
		# ryzenAdj --info
		# radg [TEMP]
		ryzenadj

		# SRC: https://github.com/nbfc-linux/nbfc-linux
		nbfc-linux

		wm2fc
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
				ryzenadj --tctl-temp=${toString tbase}
				sleep 60
			done
		'';
	};

	systemd.services.fan = {
		enable = true;
		description = "The fan control";
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			ExecStop = "${wm2fc}/bin/wm2fc a";
			Type = "simple";
		};
		path = with pkgs; [
			coreutils
			wm2fc
		];
		script = ''
			while true; do
				temp=$(cat /sys/devices/pci0000\:00/0000\:00\:18.3/hwmon/*/temp1_input)
				value=0

				if   [ $temp -gt ${toString (tbase+35)}000 ]
				then value=184
				elif [ $temp -gt ${toString (tbase+30)}000 ]
				then value=161
				elif [ $temp -gt ${toString (tbase+25)}000 ]
				then value=138
				elif [ $temp -gt ${toString (tbase+20)}000 ]
				then value=115
				elif [ $temp -gt ${toString (tbase+15)}000 ]
				then value=92
				elif [ $temp -gt ${toString (tbase+10)}000 ]
				then value=69
				elif [ $temp -gt ${toString (tbase+5)}000 ]
				then value=46
				elif [ $temp -gt ${toString tbase}000 ]
				then value=23
				fi

				wm2fc $value
				sleep 2
			done
		'';
	};

	# security.wrappers.wm2fc = {
	# 	source = "${wm2fc}/bin/wm2fc";
	# 	owner  = "root";
	# 	group  = "root";
	# 	setuid = true;
	# 	permissions = "u+rx,g+x,o+x";
	# };
}
