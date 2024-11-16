{ ... }: {
	text = ''
		# Move focus.
		bindsym --to-code $mod+a focus left
		bindsym --to-code $mod+d focus right
		bindsym --to-code $mod+s focus down
		bindsym --to-code $mod+w focus up

		# Move the focused window.
		bindsym --to-code $mod+Shift+a move left
		bindsym --to-code $mod+Shift+d move right
		bindsym --to-code $mod+Shift+s move down
		bindsym --to-code $mod+Shift+w move up

		# Focus mouse following.
		focus_follows_mouse yes
	'';
}
