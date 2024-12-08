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
		/* See the ISSUE above. */
		#custom-taghw1,
		#custom-tagbt1 {
			padding-left: ${paddingH};
		}

		#custom-taghw2,
		#custom-tagbt2 {
			padding-right: ${paddingH};
		}

		/* Padding for global widgets. */
		#clock,
		#custom-display,
		#language,
		#mpris,
		#pulseaudio,
		#scratchpad,
		#tray {
			padding: ${paddingV} ${paddingH};
		}

		/* Padding for combined widgets. */
		#cpu.load,
		#custom-powerlimit,
		#custom-powersave,
		#memory,
		#temperature {
			padding-left: 4px;
		}

		/* Hover style. */
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
			background-color: rgba(${config.module.style.color.borderR},${config.module.style.color.borderG},${config.module.style.color.borderB},${toString config.module.style.opacity.desktop});
		}

		/* Critical state. */
		#battery,
		#cpu.usage,
		#custom-display,
		#memory,
		#pulseaudio,
		#temperature,
		#tray {
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-bottom: ${toString config.module.style.window.border}px solid transparent;
		}

		#battery.critical,
		#cpu.usage.critical,
		#custom-display.modified,
		#memory.critical,
		#pulseaudio.muted,
		#pulseaudio.source-muted,
		#temperature.critical,
		#tray.needs-attention {
			border-top: ${toString config.module.style.window.border}px solid #${config.module.style.color.accent};
		}

		/* Widget-specific styling. */
		#workspaces button {
			padding: ${paddingV} 4px;
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-bottom: ${toString config.module.style.window.border}px solid transparent;
			border-radius: 0;
		}

		#workspaces button.focused {
			border-top: ${toString config.module.style.window.border}px solid #${config.module.style.color.accent};
		}

		#clock {
			font-weight: bold;
		}
	'';
}
