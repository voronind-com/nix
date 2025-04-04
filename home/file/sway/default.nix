{
  __findFile,
  config,
  lib,
  pkgs,
  util,
  ...
}:
let
  fontName = config.module.style.font.sansSerif.name;
  keyboardLayouts = config.module.keyboard.layouts;
  keyboardOptions = config.module.keyboard.options;
  timeoutCursor = config.module.style.timeout.cursor;

  accent = config.module.style.color.accent + alpha;
  alpha = config.module.style.opacity.hex;
  border = config.module.style.color.border + alpha;
  borderSize = config.module.style.window.border;
  fg = config.module.style.color.fg.light;
  opacity = "26";
  selection = "slurp -d -b ${config.module.style.color.bg.light}${opacity} -c ${config.module.style.color.fg.light} -w 0 -s 00000000";
  wallpaper = config.module.wallpaper.path;
  windowGap = config.module.style.window.gap;

  codec = "libsvtav1";
  container = "mp4";
  format = "%Y-%m-%d_%H-%M-%S";
  framerate = 30;

  notifyStart = ''swayscript notify_short'';
  notifyEnd = ''swayscript notify_long'';
  picEdit = ''swappy -f - -o -'';
  picFull = ''-o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -'';
  picPrepFile = prepFile "\${XDG_PICTURES_DIR[0]}" "png";
  picRefLatestFile = refLatestFile "png";
  picSelected = ''-g "''${scrSelection}" -'';
  picToBuffer = ''wl-copy -t image/png'';
  picToFile = ''tee "''${scrFile}"'';
  screenshot = ''grim'';
  updateWaybar = ''{ pkill -RTMIN+4 waybar; } & disown''; # NOTE: Might need to add a delay here if it becomes inconsistent one day.
  vidPrepFile = prepFile "\${XDG_VIDEOS_DIR[0]}" container;
  vidRefLatestFile = refLatestFile container;
  vidStop = ''pkill -SIGINT wf-recorder'';

  prepFile = path: ext: ''
    # Focused app id by default.
    curWindow=$(printf "%s" $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .app_id') | parse_filename)

    # If no id (i.e. xwayland), then use a name (title).
    [[ "''${curWindow}" = "null" ]] && curWindow=$(printf "%s" $(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .name') | parse_filename)

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
    scrLatest="''${scrPath}/latest.${ext}"
    rm "''${scrLatest}"
    rm "''${scrPath}/Latest.${ext}" # Remove old format, temporary.
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

  # NOTE: Use HW/fast encoder for intensive fullscreen rec and re-encode later.
  vidStartFull = ''
    wf-recorder \
      --codec h264_vaapi \
      --device /dev/dri/renderD128 \
      --no-damage \
      --framerate ${toString framerate} \
      --file "''${scrFile}" \
      -o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") - ||
    wf-recorder \
      --codec libx264 \
      --no-damage \
      --framerate ${toString framerate} \
      --file "''${scrFile}" \
      -o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") -
  '';

  vidStartSelected = ''
    wf-recorder \
      --codec ${codec} \
      --no-damage \
      --framerate ${toString framerate} \
      --file "''${scrFile}" \
      --geometry "''${scrSelection}"
  '';

  # NOTE: Only fullscreen rec is re-encoded.
  vidEncode = ''
    ffmpeg \
      -i "''${scrFile}" \
      -c:v ${codec} \
      -f ${container} \
      -svtav1-params "lp=1" \
      "''${scrFile}_" \
    && mv "''${scrFile}_" "''${scrFile}" \
    || rm "''${scrFile}_"
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

  SelectRecording =
    pkgs.writeShellScriptBin "select-recording" ''
      ${vidStop} || {
        ${getSelection}
        ${getTransform}
        ${vidPrepFile}
        ${notifyStart}
        ${updateWaybar}
        ${vidStartSelected}
        ${notifyEnd}
        ${updateWaybar}
        ${vidMuxAudio}
        ${vidTransform}
        ${vidRefLatestFile}
      };
    ''
    |> lib.getExe;

  FullscreenRecording =
    pkgs.writeShellScriptBin "fullscreen-recording" ''
      ${vidStop} || {
        ${getTransform}
        ${vidPrepFile}
        ${notifyStart}
        ${updateWaybar}
        ${vidStartFull}
        ${notifyEnd}
        ${updateWaybar}
        ${vidEncode}
        ${vidMuxAudio}
        ${vidTransform}
        ${vidRefLatestFile}
      };
    ''
    |> lib.getExe;

  FullscreenScreenshot =
    pkgs.writeShellScriptBin "fullscreen-screenshot" ''
      ${notifyEnd}
      ${picPrepFile}

      ${screenshot} ${picFull} | ${picToFile} | ${picToBuffer}
      ${picRefLatestFile}
    ''
    |> lib.getExe;

  SelectScreenshot =
    pkgs.writeShellScriptBin "select-screenshot" ''
      ${getSelection}
      ${notifyStart}
      ${picPrepFile}

      ${screenshot} ${picSelected} | ${picEdit} | ${picToFile} | ${picToBuffer}
      ${notifyEnd}
      ${picRefLatestFile}
    ''
    |> lib.getExe;

  swayRcRaw = pkgs.writeText "sway-rc-raw" (util.readFiles (util.ls ./module));

  swayRc =
    (pkgs.replaceVars swayRcRaw {
      inherit
        FullscreenRecording
        FullscreenScreenshot
        SelectRecording
        SelectScreenshot
        accent
        border
        borderSize
        fg
        fontName
        keyboardLayouts
        keyboardOptions
        timeoutCursor
        wallpaper
        windowGap
        ;
    }).overrideAttrs
      (old: {
        doCheck = false;
      });
in
{
  text =
    ''
      # Read `man 5 sway` for a complete reference.
      include /etc/sway/config.d/*
    ''
    + builtins.readFile swayRc
    + lib.optionalString config.module.wallpaper.video "exec wallpaper-video\n"
    + lib.concatStringsSep "\n" config.module.sway.extraConfig
    + "\n"
    + ''
      exec 'systemctl restart --user gui-session.target'
    '';
}
