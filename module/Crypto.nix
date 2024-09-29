{ pkgs, ... }: {
	# GPG.
	services.udev.packages = [ pkgs.yubikey-personalization ];

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
		pinentryPackage  = pkgs.pinentry-tty;
	};

	# PCSC.
	services.pcscd.enable = true;

	# Yubikey touch notification.
	# ISSUE: Not working on Sway with Mako for some reason.
	programs.yubikey-touch-detector.enable = true;

	environment.systemPackages = with pkgs; [
		yubikey-manager
		# yubioath-desktop # OTP.
	];

	# Store GPG data on tmpfs.
	# environment.variables = {
	# 	GNUPGHOME = "$(mktemp -d -t gnupg-$(date +%Y-%m-%d)-XXXXXXXXXX)";
	# };
}
