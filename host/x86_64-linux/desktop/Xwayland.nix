{ pkgs, ... }:
{
  systemd.user.services.xwayland-monitor = {
    enable = true;
    description = "Fix xwayland default monitor";
    wantedBy = [ "gui-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --primary";
      Type = "oneshot";
    };
  };
}
