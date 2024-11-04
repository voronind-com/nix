{ ... }: {
	text = ''
		# Burn specified iso file to DVD.
		# Usage: dvd_burn_iso <FILE.iso>
		function dvd_burn_iso() {
			local iso="''${1}"
			if [[ "''${iso}" = "" ]]; then
				help dvd_burn_iso
				return 2
			fi

			growisofs -dvd-compat -speed=8 -use-the-force-luke=tty -Z /dev/sr0="''${iso}"
		}

		# Burn specified iso file to CD.
		# Usage: cd_burn_iso <FILE.iso>
		function cd_burn_iso() {
			local iso="''${1}"
			if [[ "''${iso}" = "" ]]; then
				help cd_burn_iso
				return 2
			fi

			wodim speed=8 -tao dev=/dev/sr0 "''${iso}"
		}

		# Burn specified audio files to CD.
		# Usage: cd_burn_audio <FILES.wav>
		function cd_burn_audio() {
			if [[ "''${*}" = "" ]]; then
				help cd_burn_audio
				return 2
			fi

			cdrecord -v dev=/dev/sr0 speed=8 -audio -pad "''${*}"
		}

		# Spawn Nix shell with required tools.
		function dvd_shell() {
			SHELL_NAME="dvd" tmpshell dvdplusrwtools cdrkit
		}
	'';
}
