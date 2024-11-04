{
	config,
	...
}: let
	paddingH = "12px";
	paddingV = "0";
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
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-bottom: ${toString config.module.style.window.border}px solid transparent;
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
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-bottom: ${toString config.module.style.window.border}px solid transparent;
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
			background-color: rgba(${config.module.style.color.border-r},${config.module.style.color.border-g},${config.module.style.color.border-b},${toString config.module.style.opacity.desktop});
		}

		#pulseaudio.muted,
		#pulseaudio.source-muted,
		#battery.critical,
		#temperature.critical,
		#tray.needs-attention,
		#custom-display.modified {
			border-top: ${toString config.module.style.window.border}px solid #${config.module.style.color.accent};
		}

		#workspaces button {
			padding: ${paddingV} 4px;
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-bottom: ${toString config.module.style.window.border}px solid transparent;
			border-radius: 0;
		}

		#workspaces button.focused {
			border-top: ${toString config.module.style.window.border}px solid #${config.module.style.color.accent};
		}
	'';
}
