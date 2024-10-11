{ ... }:
{
  text = ''
    set $term foot

    bindsym --to-code $mod+Escape exec $term -e bash -i -c "tmux new-session -A -s $USER; bash -i"
  '';
}
