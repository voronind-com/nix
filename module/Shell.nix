{ lib, ... } : {
	# Remove default aliases for `l`, `ll` etc as they break my function definitions.
	environment.shellAliases = lib.mkForce {};
}
