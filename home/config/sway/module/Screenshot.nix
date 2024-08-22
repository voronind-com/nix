{ config, ... }: let
	color     = config.style.color;
	opacity   = "26";
	selection = "slurp -d -b ${color.bg.light}${opacity} -c ${color.fg.light} -w 0 -s 00000000";
in {
	text = ''
		# Fullscreen screenshot.
		# bindsym --to-code $mod+shift+v exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png

		# Select screenshot.
		bindsym --to-code $mod+v exec grim -g "$(${selection})" - | wl-copy

		# Select recording.
		bindsym --to-code $mod+shift+v exec 'pkill -SIGINT wf-recorder || wf-recorder --geometry "$(${selection})" --codec libsvtav1 --file $HOME/media/video/"$(date +%Y-%m-%d_%H-%M-%S)".mkv --framerate 10'
	'';
}
