{ pkgs, ... }:
{
  file = (pkgs.formats.ini { }).generate "KeydFirefoxConfig" {
    "firefox-esr" = {
      "alt.capslock" = "C-t"; # New tab.
      "alt.x" = "C-w"; # Close tab.
      "alt.u" = "C-S-t"; # Restore closed tab.
      "alt.q" = "C-pageup"; # Prev tab.
      "alt.e" = "C-pagedown"; # Next tab.
      "alt.Q" = "C-S-pageup"; # Move tab left.
      "alt.E" = "C-S-pagedown"; # Move tab right.
      "alt.a" = "A-left"; # Go back.
      "alt.d" = "A-right"; # Go forward.
      "alt.s" = "down"; # Scroll down.
      "alt.w" = "up"; # Scroll up.
      "alt.f" = "C-f"; # Find text.
      "alt.N" = "S-f3"; # Find prev.
      "alt.n" = "f3"; # Find next.
      "alt.space" = "f6"; # Focus address bar.
      "alt.r" = "C-f5"; # Full refresh.
      "alt.l" = "A-S-a"; # Toggle dark mode.
      "alt.m" = "C-m"; # Toggle tab mute.
      "alt.enter" = "C-S-l"; # Fill password.
    };
  };
}
