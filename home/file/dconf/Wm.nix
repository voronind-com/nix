{ lib, ... }:
{
  "org/gnome/desktop/wm/preferences" = {
    action-middle-click-titlebar = "minimize";
    action-right-click-titlebar = "menu";
    button-layout = "appmenu:close";
    focus-mode = "click"; # `click` or `sloppy`.
  };

  "org/gnome/mutter" = {
    attach-modal-dialogs = true;
    center-new-windows = true;
    dynamic-workspaces = true;
    edge-tiling = true;
    workspaces-only-on-primary = true;
  };

  "org/gnome/settings-daemon/plugins/color" = with lib.gvariant; {
    night-light-enabled = false;
    night-light-schedule-automatic = false;
    night-light-schedule-from = "0.0";
    night-light-schedule-to = "0.0";
    night-light-temperature = mkUint32 3700;
  };

  "org/gnome/shell/app-switcher" = {
    current-workspace-only = true;
  };

  "org/gnome/shell/overrides" = {
    edge-tiling = false;
  };
}
