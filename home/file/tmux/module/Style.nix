{ config, ... }:
let
  accent = config.module.style.color.accent;
  bg = config.module.style.color.bg.regular;
  fg = config.module.style.color.fg.light;
  selectionBg = config.module.style.color.selection;
  selectionFg = config.module.style.color.fg.dark;
in
{
  # ISSUE: No way to specify `choose` mode style.
  # SEE: https://github.com/tmux/tmux/issues/4264
  text = ''
    set -g mode-style "fg=#${fg} bg=#${bg} bold"

    setw -g window-status-current-style "fg=#${accent} bold"
    setw -g window-status-style ""

    set -g pane-border-style        "fg=#${bg}"
    set -g pane-active-border-style "fg=#${accent}"

    set -g status-style "fg=#${fg}"

    set -g menu-style          "fg=#${fg}"
    set -g menu-selected-style "fg=#${fg} bg=#${bg} bold"
    set -g menu-border-style   "fg=#${bg}"

    set -g popup-style        "fg=#${fg}"
    set -g popup-border-style "fg=#${bg}"

    set -g display-panes-colour        "#${bg}"
    set -g display-panes-active-colour "#${accent}"

    set -g copy-mode-position-style  "fg=#${selectionBg} bg=#${selectionFg} bold"
    set -g copy-mode-selection-style "fg=#${selectionFg} bg=#${selectionBg} bold"
  '';
}
