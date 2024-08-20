{ config, ... }: {
	text = ''
		### Input configuration
		#
		# Example configuration:
		#
		#   input "2:14:SynPS/2_Synaptics_TouchPad" {
		#       dwt enabled
		#       tap enabled
		#       natural_scroll enabled
		#       middle_emulation enabled
		#   }
		#
		# You can get the names of your inputs by running: swaymsg -t get_inputs
		# Read `man 5 sway-input` for more information about this section.

		input type:pointer {
			accel_profile flat
			pointer_accel 0
			dwt enabled
			tap enabled
			natural_scroll enabled
			middle_emulation enabled
		}

		input type:touchpad {
			accel_profile flat
			pointer_accel 0
			dwt enabled
			tap enabled
			natural_scroll enabled
			middle_emulation enabled
		}

		input type:keyboard {
			xkb_layout ${config.setting.keyboard.layouts}
			xkb_options ${config.setting.keyboard.options}
		}

		# Hide mouse cursor after a period of inactivity.
		seat seat0 hide_cursor 5000

		# Per-window languages.
		exec swaykbdd
	'';
}
