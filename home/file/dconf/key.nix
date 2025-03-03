{ ... }:
let
  mod = "<Super>";
in
{
  "org/gnome/desktop/wm/keybindings" = {
    activate-window-menu = [ "" ];
    begin-move = [ "" ];
    begin-resize = [ "${mod}r" ];
    close = [ "${mod}x" ];
    cycle-group = [ "" ];
    cycle-group-backward = [ "" ];
    cycle-panels = [ "" ];
    cycle-panels-backward = [ "" ];
    cycle-windows = [ "" ];
    cycle-windows-backward = [ "" ];
    maximize = [ "" ];
    maximize-horizontally = [ "" ];
    minimize = [ "${mod}s" ];
    move-to-monitor-down = [ "" ];
    move-to-monitor-left = [ "" ];
    move-to-monitor-right = [ "" ];
    move-to-monitor-up = [ "" ];
    move-to-workspace-1 = [ "" ];
    move-to-workspace-2 = [ "" ];
    move-to-workspace-3 = [ "" ];
    move-to-workspace-4 = [ "" ];
    move-to-workspace-last = [ "" ];
    move-to-workspace-left = [ "<Shift>${mod}q" ];
    move-to-workspace-right = [ "<Shift>${mod}e" ];
    panel-run-dialog = [ "${mod}space" ];
    show-desktop = [ "${mod}c" ];
    switch-applications = [ "${mod}Tab" ];
    switch-applications-backward = [ "<Shift>${mod}Tab" ];
    switch-group = [ "<Alt>Tab" ];
    switch-group-backward = [ "<Shift><Alt>Tab" ];
    switch-input-source = [ "" ];
    switch-input-source-backward = [ "" ];
    switch-panels = [ "" ];
    switch-panels-backward = [ "" ];
    switch-to-workspace-1 = [ "" ];
    switch-to-workspace-2 = [ "" ];
    switch-to-workspace-3 = [ "" ];
    switch-to-workspace-4 = [ "" ];
    switch-to-workspace-last = [ "" ];
    switch-to-workspace-left = [ "${mod}q" ];
    switch-to-workspace-right = [ "${mod}e" ];
    switch-windows = [ "" ];
    switch-windows-backward = [ "" ];
    toggle-fullscreen = [ "${mod}f" ];
    toggle-maximized = [ "${mod}w" ];
    unmaximize = [ "" ];
  };

  "org/gnome/mutter/keybindings" = {
    toggle-tiled-left = [ "${mod}a" ];
    toggle-tiled-right = [ "${mod}d" ];
  };

  "org/gnome/mutter/wayland/keybindings" = {
    restore-shortcuts = [ "" ];
  };

  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
    ];
    magnifier = [ "" ];
    magnifier-zoom-in = [ "" ];
    magnifier-zoom-out = [ "" ];
    screenreader = [ "" ];
    screensaver = [ "${mod}z" ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "${mod}Escape";
    command = "kgx -e bash -c 'tmux new-session -A -s main; bash'";
    name = "gnome-terminal";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    binding = "printz";
    command = "systemctl suspend -i";
    name = "System Sleep";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
    binding = "printx";
    command = "systemctl poweroff -i";
    name = "System Poweroff";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
    binding = "printc";
    command = "systemctl reboot -i";
    name = "System Reboot";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
    binding = "printp";
    command = "powersave toggle";
    name = "Toggle Powersave";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
    binding = "printl";
    command = "powerlimit toggle";
    name = "Toggle Powerlimit";
  };

  "org/gnome/shell/keybindings" = {
    focus-active-notification = [ "" ];
    open-application-menu = [ "" ];
    show-screenshot-ui = [ "${mod}v" ];
    switch-to-application-1 = [ "" ];
    switch-to-application-2 = [ "" ];
    switch-to-application-3 = [ "" ];
    switch-to-application-4 = [ "" ];
    switch-to-application-5 = [ "" ];
    switch-to-application-6 = [ "" ];
    switch-to-application-7 = [ "" ];
    switch-to-application-8 = [ "" ];
    switch-to-application-9 = [ "" ];
    toggle-application-view = [ "" ];
    toggle-message-tray = [ "" ];
    toggle-overview = [ "" ];
    toggle-quick-settings = [ "" ];
  };
}
