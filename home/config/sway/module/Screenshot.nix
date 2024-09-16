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
		picEdit          = ''swappy -f - -o -'';
		picFull          = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
		picPrepFile      = prepFile "\${XDG_PICTURES_DIR[0]}" "png";
		picRefLatestFile = refLatestFile "png";
		picSelected      = ''-g "''${scrSelection}" -'';
		picToBuffer      = ''wl-copy -t image/png'';
		picToFile        = ''tee "''${scrFile}"'';
		screenshot       = ''grim'';
		updateWaybar     = ''pkill -RTMIN+4 waybar''; # NOTE: Might need to add a delay here if it becomes inconsistent one day.
		vidFull          = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
		vidPrepFile      = prepFile "\${XDG_VIDEOS_DIR[0]}"   container;
		vidRefLatestFile = refLatestFile container;
		vidSelected      = ''--geometry "''${scrSelection}"'';
		vidStop          = ''pkill -SIGINT wf-recorder'';

		prepFile = path: ext: ''
			# Focused app id by default.
			curWindow=$(parse_snake $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .app_id'))

			# If no id (i.e. xwayland), then use a name (title).
			[[ "''${curWindow}" = "null" ]] && curWindow=$(parse_snake $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .name'))

			# If no app in focus, use "unknown" dir.
			[[ "''${curWindow}" =~ ^[0-9]+$ ]] && curWindow="unknown"

			# Prepare dir and file path.
			scrPath="${path}"
			scrDir="${path}/''${curWindow}"
			mkdir -p "''${scrDir}"
			scrName="$(date +${format}).${ext}"
			scrFile="''${scrDir}/''${scrName}"
			scrLatestRef="./''${curWindow}/''${scrName}"
		'';

		refLatestFile = ext: ''
			scrLatest="''${scrPath}/Latest.${ext}"
			rm "''${scrLatest}"
			ln -s "''${scrLatestRef}" "''${scrLatest}"
		'';

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
				${vidRefLatestFile}
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
				${vidRefLatestFile}
				${updateWaybar}
			};
		'';

		FullscreenScreenshot = pkgs.writeShellScriptBin "FullscreenScreenshot" ''
			${picPrepFile}

			${screenshot} ${picFull} | ${picToFile} | ${picToBuffer} && ${picRefLatestFile}
		'';

		SelectScreenshot = pkgs.writeShellScriptBin "SelectScreenshot" ''
			${getSelection}
			${picPrepFile}

			${screenshot} ${picSelected} | ${picEdit} | ${picToFile} | ${picToBuffer} && ${picRefLatestFile}
		'';
	in ''
		bindsym --to-code $mod+y       exec ${lib.getExe FullscreenScreenshot}
		bindsym --to-code $mod+shift+y exec ${lib.getExe FullscreenRecording}

		bindsym --to-code $mod+v       exec ${lib.getExe SelectScreenshot}
		bindsym --to-code $mod+shift+v exec ${lib.getExe SelectRecording}
	'';
}
