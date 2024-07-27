{ ... }: {
	text = ''
		# Enable monitors.
		function monon() {
			on() {
				swaymsg "output \"ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165\" power on"
				swaymsg "output \"AU Optronics 0x418D Unknown\" power on"
				swaymsg "output \"AOC 24G2W1G4 ATNL61A129625\" power on"
				_monstate on
			}
			_sway_iterate_sockets on
		}

		# Disable monitors.
		function monoff() {
			off() {
				swaymsg "output \"ASUSTek COMPUTER INC ASUS VA24E R2LMTF127165\" power off"
				swaymsg "output \"AU Optronics 0x418D Unknown\" power off"
				swaymsg "output \"AOC 24G2W1G4 ATNL61A129625\" power off"
				_monstate off
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
			local class=""

			if [[ "''${__monstate}" = "off" ]] || [[ "''${__gamingstate}" = "on" ]]; then
				class="modified"
			fi

			printf "{\"text\": \"󰍹\", \"tooltip\": \"Monitor: ''${__monstate^} / Gaming: ''${__gamingstate^}\", \"class\": \"''${class}\"}\n"
		}

		function _monstate() {
			if [[ "''${1}" = "" ]]; then
				cat /tmp/.monstate 2> /dev/null || echo on
			else
				echo "''${*}" > /tmp/.monstate
			fi
		}
	'';
}
