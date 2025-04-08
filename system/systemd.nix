{
  systemd = {
    coredump.enable = false;

    # HACK: Fix for broken tmpfiles setup for some services like PowerLimit.
    timers.tmpfilesfix = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = 5;
        Unit = "systemd-tmpfiles-resetup.service";
      };
    };

    # Systemd custom target for Sway.
    user.targets.gui-session = {
      after = [ "graphical-session-pre.target" ];
      bindsTo = [ "graphical-session.target" ];
      description = "GUI session.";
      documentation = [ "man:systemd.special(7)" ];
      wants = [ "graphical-session-pre.target" ];
    };
  };
}
