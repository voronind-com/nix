{ ... }: {
	text = ''
		# Enable monitors.
		function monon() {
			on() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				swaymsg "output \"''${output}\" power on"
			}
			_sway_iterate_sockets on
		}

		# Disable monitors.
		function monoff() {
			off() {
				local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
				swaymsg "output \"''${output}\" power off"
			}
			_sway_iterate_sockets off
		}

		# Toggle monitors.
		function montoggle() {
			if [[ "$(_monstate)" = "on" ]]; then
				monoff
			else
				monon
			fi
		}

		function monbar() {
			local __monstate=$(_monstate)
			local __gamingstate=$(_gamingstate)
			local __recording=$(_recording)
			local class=""

			if [[ "''${__monstate}" = "off" ]] || [[ "''${__gamingstate}" = "on" ]] || [[ "''${__recording}" = "on" ]]; then
				class="modified"
			fi

			printf "{\"text\": \"󰍹\", \"tooltip\": \"Monitor: ''${__monstate^} / Gaming: ''${__gamingstate^} / Recording: ''${__recording^}\", \"class\": \"''${class}\"}\n"
		}

		function _monstate() {
			local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .power'))

			for state in "''${outputs[@]}"; do
				''${state} || {
					echo off
					return 1
				}
			done

			echo on
			return 0
		}

		function _recording() {
			[[ "$(ps cax | rg wf-recorder)" = "" ]] && echo off || echo on
		}

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
