{ ... }: {
	text = ''
		# Show last notification.
		bindsym --to-code $mod+shift+n exec makoctl restore

		# Hide all notifications.
		bindsym --to-code $mod+n exec makoctl dismiss --all
	'';
}