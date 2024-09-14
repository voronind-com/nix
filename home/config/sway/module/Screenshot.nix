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
		picEdit      = ''| swappy -f - -o -'';
		picFile      = ''scrFile="''${XDG_PICTURES_DIR[0]}/$(date +${format}).png"'';
		picFull      = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
		picSelect    = ''-g "''${scrSelection}" -'';
		picToBuffer  = ''| wl-copy -t image/png'';
		picToFile    = ''| tee "''${scrFile}"'';
		screenshot   = ''grim'';
		updateWaybar = ''pkill -RTMIN+4 waybar'';
		vidFile      = ''scrFile="''${XDG_VIDEOS_DIR[0]}/$(date +${format}).${container}"'';
		vidFull      = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
		vidSelect    = ''--geometry "''${scrSelection}"'';
		vidStop      = ''pkill -SIGINT wf-recorder'';

		getSelection = ''
			scrSelection=$(${selection})
			[[ -n "''${scrSelection}" ]] || exit
		'';

		getTransform = ''
			scrTransform="$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .transform')"
			[[ "''${scrTransform}" = "normal" ]] && scrTransform=""
		'';

		vidStart = ''
			wf-recorder \
				--codec ${codec} \
				--file "''${scrFile}" \
				--framerate ${toString framerate} \
				--pixel-format ${pixfmt} \
		'';

		vidMuxAudio = ''
			ffmpeg \
				-f lavfi \
				-i anullsrc=channel_layout=stereo:sample_rate=44100 \
				-i "''${scrFile}" \
				-c:v copy \
				-c:a libopus \
				-shortest \
				-f ${container} \
				"''${scrFile}_" \
			&& mv "''${scrFile}_" "''${scrFile}" \
			|| rm "''${scrFile}_"
		'';

		vidTransform = ''
			if [[ -n "''${scrTransform}" ]]; then
				ffmpeg \
					-display_rotation ''${scrTransform} \
					-i "''${scrFile}" \
					-c copy \
					-f ${container} \
					"''${scrFile}_" \
				&& mv "''${scrFile}_" "''${scrFile}" \
				|| rm "''${scrFile}_"
			fi
		'';

		SelectRecording = pkgs.writeShellScriptBin "SelectRecording" ''
			${vidStop} || {
				${getSelection}
				${vidFile}
				${getTransform}
				${updateWaybar}
				${vidStart} ${vidSelect}
				${vidMuxAudio}
				${vidTransform}
				${updateWaybar}
			};
		'';

		FullscreenRecording = pkgs.writeShellScriptBin "FullscreenRecording" ''
			${vidStop} || {
				${vidFile}
				${getTransform}
				${updateWaybar}
				${vidStart} ${vidFull}
				${vidMuxAudio}
				${vidTransform}
				${updateWaybar}
			};
		'';

		FullscreenScreenshot = pkgs.writeShellScriptBin "FullscreenScreenshot" ''
			${picFile}

			${screenshot} ${picFull} ${picToFile} ${picToBuffer}
		'';

		SelectScreenshot = pkgs.writeShellScriptBin "SelectScreenshot" ''
			${getSelection}
			${picFile}

			${screenshot} ${picSelect} ${picEdit} ${picToFile} ${picToBuffer}
		'';
	in ''
		# Fullscreen screenshot.
		bindsym --to-code $mod+y exec ${lib.getExe FullscreenScreenshot}

		# Fullscreen recording.
		bindsym --to-code $mod+shift+y exec ${lib.getExe FullscreenRecording}

		# Select screenshot.
		bindsym --to-code $mod+v exec ${lib.getExe SelectScreenshot}

		# Select recording.
		bindsym --to-code $mod+shift+v exec ${lib.getExe SelectRecording}
	'';
}
