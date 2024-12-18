{ config, ... }:
{
  text = ''
    # Toggle tiling.
    bindsym --to-code $mod+shift+f floating toggle

    # Swap focus between the tiling area and the floating area
    bindsym --to-code $mod+r focus mode_toggle

    # Split directions.
    bindsym --to-code $mod+backslash splith
    bindsym --to-code $mod+minus     splitv

    # Switch the current container between different layout styles.
    bindsym --to-code $mod+Tab layout toggle split tabbed

    # Fullscreen.
    bindsym --to-code $mod+f fullscreen

    # Drag floating windows by holding down $mod and left mouse button.
    # Resize them with right mouse button + $mod.
    # Despite the name, also works for non-floating windows.
    # Change normal to inverse to use left mouse button for resizing and right
    # mouse button for dragging.
    floating_modifier $mod normal

    # Kill focused window.
    bindsym --to-code $mod+x kill

    # Add gaps.
    gaps inner ${toString config.module.style.window.gap}

    # Launch everything tiled.
    # for_window [all] floating disable
  '';
}
