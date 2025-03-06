# Recursively change permissions to allow read sharing with group and others.
function perm_share() {
	find . -type d -exec chmod +55 {} \;
	find . -type f -exec chmod +44 {} \;
}

# Recursively change permissions to allow full sharing with group and others.
function perm_full() {
	find . -type d -exec chmod +77 {} \;
	find . -type f -exec chmod +66 {} \;
}

# Recursively change permissions to allow full sharing with group.
function perm_group() {
	find . -type d -exec chmod +70 {} \;
	find . -type f -exec chmod +60 {} \;
}

# Recursively change permissions to restrict access for group and others.
function perm_private() {
	find . -exec chmod -77 {} \;
}
