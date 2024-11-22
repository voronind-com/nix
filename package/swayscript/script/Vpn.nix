{ ... }: {
	text = ''
		# Toggle vpn.
		function vpn() {
			notify_short
			if [[ "$(_vpn)" = "on" ]]; then
				nmcli connection down vpn
			else
				nmcli connection up vpn
			fi
		}

		function _vpn() {
			local state=$(nmcli connection show vpn | rg -i state.*activated)
			[ "''${state}" != "" ] && printf on || printf off
		}
	'';
}
