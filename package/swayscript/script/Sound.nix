{ ... }: {
	text = ''
		function sound_output_cycle() {
			local IFS=$'\n'
			local current=$(pactl get-default-sink)
			local all=($(pactl list short sinks | cut -f2))
			local i_current=$(_index_of ''${current} ''${all[@]})
			local i_total=''${#all[@]}; ((i_total--))
			local i_target=0

			[[ "''${i_current}" -lt "''${i_total}" ]] && i_target=$((i_current+1))

			pactl set-default-sink ''${all[''${i_target}]}
		}
	'';
}
