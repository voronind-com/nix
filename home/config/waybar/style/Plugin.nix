{ config, ... }: let
	paddingV = "0";
	paddingH = "12px";
in {
	# ISSUE: https://github.com/Alexays/Waybar/issues/3303
	# This way I am forced to apply the padding to children of each group
	# instead of the whole group.
	text = ''
		#clock,
		#custom-display,
		#language,
		#mpris,
		#pulseaudio,
		#scratchpad,
		#tray {
			padding: ${paddingV} ${paddingH};
			border-top: ${toString config.style.window.border}px solid transparent;
			border-bottom: ${toString config.style.window.border}px solid transparent;
		}

		#cpu,
		#battery {
			padding-left: ${paddingH};
		}

		#custom-powersave,
		#custom-powerlimit {
			padding-right: ${paddingH};
		}

		#clock {
			font-weight: bold;
		}

		#custom-powerlimit,
		#custom-powersave,
		#memory,
		#temperature {
			padding-left: 4px;
		}

		#batteryinfo:hover,
		#clock:hover,
		#custom-display:hover,
		#hardware:hover,
		#language:hover,
		#mpris:hover,
		#pulseaudio:hover,
		#scratchpad:hover,
		#tray:hover,
		#workspaces button:hover {
			background-color: rgba(${config.style.color.border-r},${config.style.color.border-g},${config.style.color.border-b},${toString config.style.opacity.desktop});
		}

		#pulseaudio.muted,
		#pulseaudio.source-muted,
		#battery.critical,
		#temperature.critical,
		#tray.needs-attention,
		#custom-display.modified {
			border-top: ${toString config.style.window.border}px solid #${config.style.color.accent};
		}

		#workspaces button {
			padding: ${paddingV} 4px;
			border-top: ${toString config.style.window.border}px solid transparent;
			border-radius: 0;
		}

		#workspaces button.focused {
			border-top: ${toString config.style.window.border}px solid #${config.style.color.accent};
		}
	'';
}
