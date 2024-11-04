{ ... }: {
	text = ''
		# Print current battery charge level in percents.
		function battery_level() {
			head -c -1 /sys/class/power_supply/BAT*/capacity
			echo '%'
		}

		# Get battery's info.
		function battery_info() {
			local IFS=$'\n'
			local battery=("$(upower --enumerate | grep battery_BAT)")
			upower -i "''${battery[0]}"
		}
	'';
}
