{ ... }: {
	text = ''
		bind-key -n M-f set-option -g status;
		set -g status-left-length 50
		set -g status-position bottom
		set -g status-justify  left

		set -g status-left "#[bold] #H-#S #[default]"
		set -g status-right ""

		set-window-option -g window-status-separator ""

		setw -g window-status-current-format " #W "
		setw -g window-status-format " #W "

		set-window-option -g visual-bell off
		setw -g window-status-bell-style "bold blink"
	'';
}
