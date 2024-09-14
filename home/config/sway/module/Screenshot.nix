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
		picFull      = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
		picSelected  = ''-g "''${scrSelection}" -'';
		picToBuffer  = ''| wl-copy -t image/png'';
		picToFile    = ''| tee "''${scrFile}"'';
		screenshot   = ''grim'';
		updateWaybar = ''pkill -RTMIN+4 waybar'';
		vidFull      = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
		vidSelected  = ''--geometry "''${scrSelection}"'';
		vidStop      = ''pkill -SIGINT wf-recorder'';

		prepFile = path: ext: ''
			# Focused app id by default.
			curWindow=$(parse_snake $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .app_id'))

			# If no id (i.e. xwayland), then use a name (title).
			[[ "''${curWindow}" = "null" ]] && curWindow=$(parse_snake $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .name'))

			# If no app in focus, use "unknown" dir.
			[[ "''${curWindow}" -eq "''${curWindow}" ]] && curWindow="unknown"

			# Prepare dir and file path.
			scrDir="${path}/''${curWindow}"
			mkdir -p "''${scrDir}"
			scrFile="''${scrDir}/$(date +${format}).${ext}"
		'';

		vidPrepFile = prepFile "\${XDG_VIDEOS_DIR[0]}"   container;
		picPrepFile = prepFile "\${XDG_PICTURES_DIR[0]}" "png";

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
				${getTransform}
				${vidPrepFile}
				${updateWaybar}
				${vidStart} ${vidSelected}
				${vidMuxAudio}
				${vidTransform}
				${updateWaybar}
			};
		'';

		FullscreenRecording = pkgs.writeShellScriptBin "FullscreenRecording" ''
			${vidStop} || {
				${getTransform}
				${vidPrepFile}
				${updateWaybar}
				${vidStart} ${vidFull}
				${vidMuxAudio}
				${vidTransform}
				${updateWaybar}
			};
		'';

		FullscreenScreenshot = pkgs.writeShellScriptBin "FullscreenScreenshot" ''
			${picPrepFile}

			${screenshot} ${picFull} ${picToFile} ${picToBuffer}
		'';

		SelectScreenshot = pkgs.writeShellScriptBin "SelectScreenshot" ''
			${getSelection}
			${picPrepFile}

			${screenshot} ${picSelected} ${picEdit} ${picToFile} ${picToBuffer}
		'';
	in ''
		bindsym --to-code $mod+y       exec ${lib.getExe FullscreenScreenshot}
		bindsym --to-code $mod+shift+y exec ${lib.getExe FullscreenRecording}

		bindsym --to-code $mod+v       exec ${lib.getExe SelectScreenshot}
		bindsym --to-code $mod+shift+v exec ${lib.getExe SelectRecording}
	'';
}
