{ config, ... }: let
	paddingV = "0";
	paddingH = "12px";
in {
	text = ''
		#pulseaudio,
		#mpris,
		#battery,
		#custom-display,
		#custom-powersave,
		#custom-powerlimit,
		#tray,
		#temperature,
		#memory,
		#cpu,
		#clock,
		#scratchpad,
		#language {
			padding: ${paddingV} ${paddingH};
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-bottom: ${toString config.module.style.window.border}px solid transparent;
		}

		#cpu {
			padding-right: 0;
		}

		#temperature {
			padding-left: 0;
			padding-right: 0;
		}

		#memory {
			padding-left: 0;
		}

		#custom-powersave,
		#custom-powerlimit {
			margin-left: -${paddingH};
			padding-left: 0;
		}

		#clock {
			font-weight: bold;
		}

		#battery:hover,
		#clock:hover,
		#cpu:hover,
		#custom-display:hover,
		#custom-powerlimit:hover,
		#custom-powersave:hover,
		#language:hover,
		#memory:hover,
		#mpris:hover,
		#pulseaudio:hover,
		#temperature:hover,
		#tray:hover,
		#scratchpad:hover,
		#workspaces button:hover {
			background-color: rgba(${config.module.style.color.border-r},${config.module.style.color.border-g},${config.module.style.color.border-b},${toString config.module.style.opacity.desktop});
		}

		#pulseaudio.muted,
		#battery.critical,
		#tray.needs-attention,
		#custom-display.modified {
			border-top: ${toString config.module.style.window.border}px solid #${config.module.style.color.accent};
		}

		#workspaces button {
			padding: ${paddingV} 4px;
			border-top: ${toString config.module.style.window.border}px solid transparent;
			border-radius: 0;
		}

		#workspaces button.focused {
			border-top: ${toString config.module.style.window.border}px solid #${config.module.style.color.accent};
		}
	'';
}
