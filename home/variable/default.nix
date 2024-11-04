{ pkgs, ... }: {
	# Default text editor.
	EDITOR = "nvim";

	# App to use for man pages.
	MANPAGER = "nvim +Man!";

	# Allow unfree packages in shell.
	NIXPKGS_ALLOW_UNFREE = "1";

	# Current system architecture.
	NIX_CURRENT_SYSTEM = "${pkgs.stdenv.system}";

	# Enable Mangohud by default.
	MANGOHUD = "1";

	# Use fsync for Wine.
	WINEFSYNC = "1";

	# Disable Firefox profile switching on rebuild.
	MOZ_LEGACY_PROFILES = "1";

	# GTK apps compat.
	GTK_CSD = 0;

	# Terminal settings.
	TERM = "xterm-256color";
}
