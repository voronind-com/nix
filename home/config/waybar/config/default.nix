{ config, pkgs, ... }: let
	refreshInterval = 2;
in {
	file = (pkgs.formats.json {}).generate "WaybarConfig" {
		height       = 34;
		layer        = "top"; margin-left  = config.style.window.gap;
		margin-right = config.style.window.gap;
		margin-top   = config.style.window.gap;
		mode         = "dock";
		position     = "top";
		spacing      = 4;
		start_hidden = false;
		output = [
			"!Huawei Technologies Co., Inc. ZQE-CBA 0xC080F622" # Desktop monitor.
			"!AOC 24G2W1G4 ATNL61A129625" # Dasha monitor.
			"!UGD Artist15.6Pro 20200316" # XP-Pen Tablet.
			"*"
		];
		modules-left = [
			"sway/workspaces"
			"sway/scratchpad"
		];
		modules-center = [
			"clock"
			"mpris"
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
			tooltip = false;
			on-click       = "swaymsg 'input * xkb_switch_layout next'";
			on-click-right = "xdg-open https://translate.yandex.ru/";
		};
		"sway/scratchpad" = {
			format         = "{icon}  {count}";
			show-empty     = false;
			format-icons   = [ "" "" ];
			tooltip        = true;
			tooltip-format = "{app}: {title}";
			on-click       = "swaymsg 'scratchpad show'";
			on-click-right = "swayscript scratchpad_kill";
		};
		tray = {
			# icon-size = 21;
			spacing = 8;
		};
		clock = {
			# timezone = "America/New_York";
			tooltip-format = "<big><tt>{calendar}</tt></big>";
			format-alt = "{:%d %a %H:%M}";
			on-click-right = "xdg-open https://cloud.voronind.com/apps/calendar/";
		};
		battery = {
			states = {
				good     = 60;
				warning  = 40;
				critical = 2;
			};
			format          = "{capacity}% {icon}";
			format-charging = "{capacity}% ";
			format-plugged  = "{capacity}% ";
			format-alt      = "{time} {icon}";
			format-icons    = ["󰂎" "󱊡" "󱊢" "󱊣" "󱊣"];
			on-click-right  = "powerlimit toggle";
			interval        = refreshInterval;
		};
		"custom/powerlimit" = {
			exec           = "powerlimit widget";
			on-click-right = "powerlimit toggle";
			signal         = 6;
		};
		"group/batteryinfo" = {
			orientation = "horizontal";
			modules     = [ "battery" "custom/powerlimit" ];
		};
		pulseaudio = {
			scroll-step  = 5;
			format       = "{volume}%{icon}{format_source}";
			format-muted = "󰸈{format_source}";
			# format-icons = {
			# 	default = [ " " " " " " ];
			# };
			format-source       = "";
			format-source-muted = " 󰍭";
			on-click        = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
			on-click-middle = "pavucontrol";
			on-click-right  = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
		};
		mpris = {
			format        = "{player_icon}  {title} - {artist}";
			format-paused = "{status_icon}  {title} - {artist}";
			player-icons = {
				"default" = "";
				"firefox" = "󰈹";
				"mpv"     = "";
			};
			status-icons = {
				"paused" = "";
			};
			on-click-middle = "playerctl stop";
			# ignored-players = [ "firefox" ];
		};
		cpu = {
			format         = "{usage}% ({load})";
			interval       = refreshInterval;
			on-click       = "foot -e bash -c btop";
			on-click-right = "powersave toggle";
			tooltip        = false;
		};
		memory = {
			format         = "{percentage}%";
			interval       = refreshInterval;
			on-click       = "foot -e bash -c btop";
			on-click-right = "powersave toggle";
		};
		temperature = {
			critical-threshold = 80;
			format             = "{temperatureC}°C";
			hwmon-path-abs     = "${config.setting.cpu.hwmon.path}";
			input-filename     = "${config.setting.cpu.hwmon.file}";
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
		};
		"group/hardware" = {
			orientation = "horizontal";
			modules     = [ "cpu" "memory" "temperature" "custom/powersave" ];
		};
		"custom/display" = {
			exec            = "swayscript displaywidget";
			on-click        = "sleep 0.1 && swayscript dnd"; # HACK: https://github.com/Alexays/Waybar/issues/2166 & https://github.com/Alexays/Waybar/issues/1968
			on-click-right  = "sleep 0.1 && swayscript monitor";
			on-click-middle = "sleep 0.1 && swayscript gaming";
			return-type     = "json";
			signal          = 4;
		};
	};
}
