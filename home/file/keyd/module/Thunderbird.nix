{ pkgs, ... }:
{
  file = (pkgs.formats.ini { }).generate "keyd-thunderbird-config" {
    "thunderbird" = {
      "alt.x" = "C-w"; # Close tab.
      "alt.u" = "C-S-t"; # Restore closed tab.
      "alt.q" = "C-pageup"; # Prev tab.
      "alt.e" = "C-pagedown"; # Next tab.
      "alt.Q" = "C-S-pageup"; # Move tab left.
      "alt.E" = "C-S-pagedown"; # Move tab right.
      "alt.f" = "C-f"; # Find text.
      "alt.N" = "S-f3"; # Find prev.
      "alt.n" = "f3"; # Find next.
      "alt.space" = "C-k"; # Focus search bar.
    };
  };
}
