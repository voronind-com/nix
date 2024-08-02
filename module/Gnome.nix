{ pkgs, lib, config, ... }: with lib; let
	cfg = config.module.desktop.gnome;
in {
	options = {
		module.desktop.gnome.enable = mkEnableOption "Enable GnOmE";
	};

	config = mkIf cfg.enable {
		module.desktop = {
			dm.enable         = true;
			sound.enable      = true;
			wayland.enable    = true;
		};

		services.xserver.displayManager.gdm.enable   = true;
		services.xserver.desktopManager.gnome.enable = true;

		environment.systemPackages = with pkgs; [
			gnome.gnome-tweaks # Gnome "hidden" settings.
			openssl # It was needed for something, can't remember.
		];

		# Disable some Gnome apps.
		services.gnome.gnome-keyring.enable = mkForce false;
		environment.gnome.excludePackages = with pkgs.gnome; [
			# baobab      # Disk usage analyzer.
			# cheese      # Photo booth.
			# epiphany    # Web browser.
			# simple-scan # Document scanner.
			# totem       # Video player.
			# yelp        # Help viewer.
			# file-roller # Archive manager.
			# geary       # Email client.
			# seahorse    # Password manager.

			# gnome-calculator
			# gnome-calendar
			# gnome-characters
			# gnome-clocks
			# gnome-contacts
			# gnome-font-viewer
			# gnome-keyring
			# gnome-logs
			# gnome-maps
			# gnome-music
			# gnome-shell-extensions
			gnome-software
			# gnome-system-monitor
			# gnome-weather
			# gnome-disk-utility
			# pkgs.gnome-text-editor
		];
	};
}
