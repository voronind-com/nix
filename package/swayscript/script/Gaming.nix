{ ... }: {
	text = ''
		# Enable Gaming.
		function gamingon() {
			on() {
				swaymsg "output \"Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622\" adaptive_sync on"
				# swaymsg "output \"Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622\" mode 3440x1440@164.999Hz"
				swaymsg "output \"AOC 24G2W1G4 ATNL61A129625\" adaptive_sync on"
				# swaymsg "output \"AOC 24G2W1G4 ATNL61A129625\" mode 1920x1080@144.000Hz"
				_gamingstate on
			}
			_sway_iterate_sockets on
		}

		# Disable Gaming.
		function gamingoff() {
			off() {
				swaymsg "output \"Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622\" adaptive_sync off"
				# swaymsg "output \"Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622\" mode 3440x1440@59.973Hz"
				swaymsg "output \"AOC 24G2W1G4 ATNL61A129625\" adaptive_sync off"
				# swaymsg "output \"AOC 24G2W1G4 ATNL61A129625\" mode 1920x1080@60.000Hz"
				_gamingstate off
			}
			_sway_iterate_sockets off
		}

		# Toggle gaming.
		function gamingtoggle() {
			if [[ "$(_gamingstate)" = "on" ]]; then
				gamingoff
			else
				gamingon
			fi
		}

		function _gamingstate() {
			if [[ "''${1}" = "" ]]; then
				cat /tmp/.gamingstate 2> /dev/null || echo off
			else
				echo "''${*}" > /tmp/.gamingstate
			fi
		}
	'';
}
