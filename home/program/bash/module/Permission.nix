{ ... }: {
	text = ''
		# Recursively change permissions to allow read sharing with group and others.
		function perm_share() {
			find . -type d -exec chmod 755 {} \;; find . -type f -exec chmod 644 {} \;
		}

		# Recursively change permissions to restrict access for group and others.
		function perm() {
			find . -type d -exec chmod 700 {} \;; find . -type f -exec chmod 600 {} \;
		}
	'';
}
