{ pkgs, ... }:
{
  file = (pkgs.formats.ini { }).generate "keyd-firefox-config" {
    "firefox-esr" = {
      "alt.E" = "C-S-pagedown"; # Move tab right.
      "alt.N" = "S-f3"; # Find prev.
      "alt.Q" = "C-S-pageup"; # Move tab left.
      "alt.a" = "A-left"; # Go back.
      "alt.capslock" = "C-t"; # New tab.
      "alt.d" = "A-right"; # Go forward.
      "alt.e" = "C-pagedown"; # Next tab.
      "alt.enter" = "C-S-l"; # Fill password.
      "alt.f" = "C-f"; # Find text.
      "alt.l" = "A-S-a"; # Toggle dark mode.
      "alt.m" = "C-m"; # Toggle tab mute.
      "alt.n" = "f3"; # Find next.
      "alt.q" = "C-pageup"; # Prev tab.
      "alt.r" = "C-f5"; # Full refresh.
      "alt.s" = "A-p"; # Pin tab.
      "alt.space" = "f6"; # Focus address bar.
      "alt.u" = "C-S-t"; # Restore closed tab.
      "alt.w" = "macro(y t)"; # Duplicate tab.
      # "alt.W" = "macro(y t W)"; # Duplicate tab on new window. # NOTE: Use S-w to manually detach.
      "alt.x" = "C-w"; # Close tab.
    };
  };
}
