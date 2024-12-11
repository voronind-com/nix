{ ... }: {
	text = ''
		# Adjust ryzen temp limit.
		# Usage: radj [TEMP]
		function radj() {
			local limit="''${1}"
			if [[ "''${limit}" = "" ]]; then
				systemctl start radj.service
			else
				systemctl stop radj.service
				ryzenadj --tctl-temp=''${limit}
			fi
		}
	'';
}
