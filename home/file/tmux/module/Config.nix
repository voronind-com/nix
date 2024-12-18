{ ... }:
{
  text = ''
    unbind-key C-b
    set-option -g prefix C-[
    bind-key C-[ send-prefix
    bind -n M-r source-file ~/.config/tmux/tmux.conf
  '';
}
