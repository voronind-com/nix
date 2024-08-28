{ config, ... }: let
	codec     = "libsvtav1";
	color     = config.style.color;
	container = "mkv";
	format    = "%Y-%m-%d_%H-%M-%S";
	framerate = 10;
	opacity   = "26";
	selection = "slurp -d -b ${color.bg.light}${opacity} -c ${color.fg.light} -w 0 -s 00000000";
	pixfmt    = "yuv420p10le";
in {
	text = ''
		# Fullscreen screenshot.
		# bindsym --to-code $mod+shift+v exec grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') - | wl-copy -t image/png

		# Select screenshot.
		bindsym --to-code $mod+v exec grim -g "$(${selection})" - | tee "''${XDG_PICTURES_DIR[0]}/$(date +${format}).png" | wl-copy

		# Select recording.
		bindsym --to-code $mod+shift+v exec 'pkill -SIGINT wf-recorder || wf-recorder --geometry "$(${selection})" --codec ${codec} --file "''${XDG_VIDEOS_DIR[0]}/$(date +${format}).${container}" --framerate ${toString framerate} --pixel-format ${pixfmt}'
	'';
}
