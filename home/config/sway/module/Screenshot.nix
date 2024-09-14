{ config, pkgs, lib, ... }: let
	codec     = "libsvtav1";
	color     = config.style.color;
	container = "mp4";
	format    = "%Y-%m-%d_%H-%M-%S";
	framerate = 10;
	opacity   = "26";
	selection = "slurp -d -b ${color.bg.light}${opacity} -c ${color.fg.light} -w 0 -s 00000000";
	pixfmt    = "yuv420p10le";
in {
	text = let
		fullscr = pkgs.writeShellScriptBin "FullscreenScreenshot" ''
			scrFile="''${XDG_PICTURES_DIR[0]}/$(date +${format}).png"

			grim \
				-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") - \
			| tee "''${scrFile}" \
			| wl-copy -t image/png
		'';

		selectscr = pkgs.writeShellScriptBin "SelectScreenshot" ''
			scrSelection=$(${selection})
			[[ -n "''${scrSelection}" ]] || exit

			scrFile="''${XDG_PICTURES_DIR[0]}/$(date +${format}).png"

			grim \
				-g "''${scrSelection}" - \
			| swappy -f - -o - \
			| tee "''${scrFile}" \
			| wl-copy -t image/png
		'';

		selectrec = pkgs.writeShellScriptBin "SelectRecording" ''
			pkill -SIGINT wf-recorder \
			|| {
				scrSelection=$(${selection})
				[[ -n "''${scrSelection}" ]] || exit

				scrFile="''${XDG_VIDEOS_DIR[0]}/$(date +${format}).${container}"

				scrTransform="$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .transform')"
				[[ "''${scrTransform}" = "normal" ]] && scrTransform=""

				pkill -RTMIN+4 waybar \
				| wf-recorder \
					--geometry "''${scrSelection}" \
					--codec ${codec} \
					--file "''${scrFile}" \
					--framerate ${toString framerate} \
					--pixel-format ${pixfmt} \
				&& ffmpeg \
					-f lavfi \
					-i anullsrc=channel_layout=stereo:sample_rate=44100 \
					-i "''${scrFile}" \
					-c:v copy \
					-c:a libopus \
					-shortest \
					-f ${container} \
					"''${scrFile}_" \
				&& mv "''${scrFile}_" "''${scrFile}" \
				&& [[ -n "''${scrTransform}" ]] \
				&& ffmpeg \
					-display_rotation ''${scrTransform} \
					-i "''${scrFile}" \
					-c copy \
					-f ${container} \
					"''${scrFile}_" \
				&& mv "''${scrFile}_" "''${scrFile}" \
				|| rm "''${scrFile}_"

				pkill -RTMIN+4 waybar
			};
		'';

		fullrec = pkgs.writeShellScriptBin "FullscreenRecording" ''
			pkill -SIGINT wf-recorder \
			|| {
				scrFile="''${XDG_VIDEOS_DIR[0]}/$(date +${format}).${container}"
				scrTransform="$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .transform')"
				[[ "''${scrTransform}" = "normal" ]] && scrTransform=""

				pkill -RTMIN+4 waybar \
				| wf-recorder \
					-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") - \
					--codec ${codec} \
					--file "''${scrFile}" \
					--framerate ${toString framerate} \
					--pixel-format ${pixfmt} \
				&& ffmpeg \
					-f lavfi \
					-i anullsrc=channel_layout=stereo:sample_rate=44100 \
					-i "''${scrFile}" \
					-c:v copy \
					-c:a libopus \
					-shortest \
					-f ${container} \
					"''${scrFile}_" \
				&& mv "''${scrFile}_" "''${scrFile}" \
				&& [[ -n "''${scrTransform}" ]] \
				&& ffmpeg \
					-display_rotation ''${scrTransform} \
					-i "''${scrFile}" \
					-c copy \
					-f ${container} \
					"''${scrFile}_" \
				&& mv "''${scrFile}_" "''${scrFile}" \
				|| rm "''${scrFile}_"

				pkill -RTMIN+4 waybar
			};
		'';
	in ''
		# Fullscreen screenshot.
		bindsym --to-code $mod+y exec ${lib.getExe fullscr}

		# Fullscreen recording.
		bindsym --to-code $mod+shift+y exec ${lib.getExe fullrec}

		# Select screenshot.
		bindsym --to-code $mod+v exec ${lib.getExe selectscr}

		# Select recording.
		bindsym --to-code $mod+shift+v exec ${lib.getExe selectrec}
	'';
}
