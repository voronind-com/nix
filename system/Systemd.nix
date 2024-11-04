{ ... }: {
	# HACK: Fix for broken tmpfiles setup for some services like PowerLimit.
	systemd.timers.tmpfilesfix = {
		timerConfig = {
			OnBootSec = 5;
			Unit = "systemd-tmpfiles-resetup.service";
		};
		wantedBy = [
			"timers.target"
		];
	};

	# Systemd custom target for Sway.
	systemd.user.targets.gui-session = {
		after         = [ "graphical-session-pre.target" ];
		bindsTo       = [ "graphical-session.target" ];
		description   = "GUI session.";
		documentation = [ "man:systemd.special(7)" ];
		wants         = [ "graphical-session-pre.target" ];
	};
}
