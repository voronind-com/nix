{ ... }: {
	text = ''
		# Switch to workspace.
		bindsym --to-code $mod+1 workspace number 1
		bindsym --to-code $mod+2 workspace number 2
		bindsym --to-code $mod+3 workspace number 3
		bindsym --to-code $mod+4 workspace number 4
		bindsym --to-code $mod+5 workspace number 5
		bindsym --to-code $mod+6 workspace number 6
		bindsym --to-code $mod+7 workspace number 7
		bindsym --to-code $mod+8 workspace number 8
		bindsym --to-code $mod+9 workspace number 9
		bindsym --to-code $mod+0 workspace number 10

		# Move focused container to workspace.
		bindsym --to-code $mod+Shift+1 move container to workspace number 1
		bindsym --to-code $mod+Shift+2 move container to workspace number 2
		bindsym --to-code $mod+Shift+3 move container to workspace number 3
		bindsym --to-code $mod+Shift+4 move container to workspace number 4
		bindsym --to-code $mod+Shift+5 move container to workspace number 5
		bindsym --to-code $mod+Shift+6 move container to workspace number 6
		bindsym --to-code $mod+Shift+7 move container to workspace number 7
		bindsym --to-code $mod+Shift+8 move container to workspace number 8
		bindsym --to-code $mod+Shift+9 move container to workspace number 9
		bindsym --to-code $mod+Shift+0 move container to workspace number 10
		# Note: workspaces can have any name you want, not just numbers.
		# We just use 1-10 as the default.

		# Switch left-right.
		bindsym --to-code $mod+e workspace next
		bindsym --to-code $mod+q workspace prev

		# Move left-right.
		bindsym --to-code $mod+Shift+e move container to workspace next
		bindsym --to-code $mod+Shift+q move container to workspace prev
	'';
}
