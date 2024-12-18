{ ... }:
{
  text = ''
    # Application launcher.
    # Note: pass the final command to swaymsg so that the resulting window can be opened
    # on the original workspace that the command was run on.
    set $menu fuzzel

    bindsym $mod+space exec $menu
  '';
}
