{ ... }:
let
  stepHorizontal = 10;
  stepVertical = 10;
in
{
  text = ''
    bindsym --to-code $mod+j resize grow   height ${toString stepVertical}px
    bindsym --to-code $mod+k resize shrink height ${toString stepVertical}px
    bindsym --to-code $mod+h resize shrink width  ${toString stepHorizontal}px
    bindsym --to-code $mod+l resize grow   width  ${toString stepHorizontal}px
  '';
}
