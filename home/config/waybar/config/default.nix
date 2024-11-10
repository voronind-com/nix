{
	config,
	pkgs,
	...
}: let
	refreshInterval = 2;
in {
	file = (pkgs.formats.json { }).generate "WaybarConfig" {
		height       = 34;
		layer        = "top";
		margin-left  = config.module.style.window.gap;
		margin-right = config.module.style.window.gap;
		margin-top   = config.module.style.window.gap;
		mode         = "dock";
		position     = "top";
		spacing      = 4;
		start_hidden = false;
		output = [
			"!AOC 24G2W1G4 ATNL61A129625" # Dasha monitor.
			"!Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622" # Desktop monitor.
			"!UGD Artist15.6Pro 20200316" # XP-Pen Tablet.
			"*"
		];
		modules-left = [
			"clock"
			"sway/scratchpad"
			"mpris"
		];
		modules-center = [
			"sway/workspaces"
		];
		modules-right = [
			"sway/language"
			"pulseaudio"
			"group/batteryinfo"
			"group/hardware"
			"custom/display"
			"tray"
		];
		"sway/workspaces" = {
			all-outputs = true;
		};
		"sway/language" = {
			on-click       = "swaymsg 'input * xkb_switch_layout next'";
			on-click-right = "xdg-open https://translate.yandex.ru/";
			tooltip        = false;
		};
		"sway/scratchpad" = {
			format          = "{icon}  {count}";
			on-click        = "swaymsg 'scratchpad show'";
			on-click-middle = "swayscript scratchpad_kill";
			show-empty      = false;
			tooltip         = true;
			tooltip-format  = "{app}: {title}";
			format-icons = [
				""
				""
			];
		};
		tray = {
			spacing = 8;
		};
		clock = {
			format-alt     = "{:%d %a %H:%M}";
			on-click-right = "xdg-open https://cloud.voronind.com/apps/calendar/";
			tooltip-format = "<big><tt>{calendar}</tt></big>";
		};
		battery = {
			format          = "{capacity}% {icon}";
			format-alt      = "{time} {icon}";
			format-charging = "{capacity}% ";
			format-plugged  = "{capacity}% ";
			interval        = refreshInterval;
			on-click-right  = "powerlimit toggle";
			states = {
				good = 60;
				warning = 40;
				critical = 20;
			};
			format-icons = [
				"󰂎"
				"󱊡"
				"󱊢"
				"󱊣"
				"󱊣"
			];
		};
		"custom/powerlimit" = {
			exec           = "powerlimit widget";
			on-click-right = "powerlimit toggle";
			signal         = 6;
			tooltip        = false;
		};
		"group/batteryinfo" = {
			orientation = "horizontal";
			modules = [
				"battery"
				"custom/powerlimit"
			];
		};
		pulseaudio = {
			format              = "{volume}%{icon}{format_source}";
			format-muted        = "󰸈{format_source}";
			format-source       = "";
			format-source-muted = " 󰍭";
			on-click            = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
			on-click-middle     = "pavucontrol";
			on-click-right      = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
			scroll-step         = 5;
		};
		mpris = let
			maxLength = 32;
		in {
			album-len       = maxLength;
			artist-len      = maxLength;
			format          = "{player_icon}  {title} - {artist}";
			format-paused   = "{status_icon}  {title} - {artist}";
			on-click-middle = "playerctl stop";
			title-len       = maxLength;
			tooltip-format  = "{player}: {dynamic}";
			player-icons = {
				"default" = "";
				"firefox" = "󰈹";
				"mpv"     = "";
			};
			status-icons = {
				"paused" = "";
			};
		};
		cpu = {
			format          = "{usage}% ({load})";
			interval        = refreshInterval;
			on-click        = "foot -e bash -c btop";
			on-click-right  = "powersave toggle";
			states.critical = 100;
			tooltip         = false;
		};
		memory = {
			format          = "{percentage}%";
			interval        = refreshInterval;
			on-click        = "foot -e bash -c btop";
			on-click-right  = "powersave toggle";
			states.critical = 80;
		};
		temperature = {
			critical-threshold = 80;
			format             = "{temperatureC}°C";
			hwmon-path-abs     = "${config.module.hwmon.path or ""}";
			input-filename     = "${config.module.hwmon.file or ""}";
			interval           = refreshInterval;
			on-click           = "foot -e bash -c btop";
			on-click-right     = "powersave toggle";
			tooltip            = false;
		};
		"custom/powersave" = {
			exec           = "powersave widget";
			on-click       = "foot -e bash -c btop";
			on-click-right = "powersave toggle";
			signal         = 5;
			tooltip        = false;
		};
		"group/hardware" = {
			orientation = "horizontal";
			modules = [
				"custom/tag1"
				"cpu"
				"temperature"
				"memory"
				"custom/powersave"
				"custom/tag2"
			];
		};
		"custom/display" = {
			exec            = "swayscript displaywidget";
			on-click        = "sleep 0.1 && swayscript dnd"; # HACK: https://github.com/Alexays/Waybar/issues/2166 & https://github.com/Alexays/Waybar/issues/1968
			on-click-middle = "sleep 0.1 && swayscript displayreset";
			on-click-right  = "sleep 0.1 && swayscript monitor";
			return-type     = "json";
			signal          = 4;
		};
		"custom/tag1" = {
			exec = "echo ​";
		};
		"custom/tag2" = {
			exec = "echo ​";
		};
	};
}
