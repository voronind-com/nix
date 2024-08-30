{ config, ... }: let
	codec     = "libsvtav1";
	color     = config.style.color;
	container = "mp4";
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
		bindsym --to-code $mod+shift+v exec 'pkill -SIGINT wf-recorder || { export targetFile="''${XDG_VIDEOS_DIR[0]}/$(date +${format}).${container}"; wf-recorder --geometry "$(${selection})" --codec ${codec} --file "''${targetFile}" --framerate ${toString framerate} --pixel-format ${pixfmt} && ffmpeg -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 -i "''${targetFile}" -c:v copy -c:a libopus -shortest -f ${container} "''${targetFile}_" && mv "''${targetFile}_" "''${targetFile}"; }'
	'';
}
