{
	pkgs,
	...
}: {
	file = (pkgs.formats.ini { }).generate "KeydNautilusConfig" {
		"org-gnome-nautilus" = {
			"alt.capslock" = "C-t";          # New tab.
			"alt.t"        = "C-n";          # New window.
			"alt.x"        = "C-w";          # Close tab.
			"alt.u"        = "C-S-t";        # Restore tab.
			"alt.e"        = "C-pagedown";   # Next tab.
			"alt.q"        = "C-pageup";     # Prev tab.
			"alt.E"        = "C-S-pagedown"; # Move tab next.
			"alt.Q"        = "C-S-pageup";   # Move tab prev.
			"alt.h"        = "C-h";          # Toggle hidden files.
			"alt.1"        = "C-1";          # List view.
			"alt.2"        = "C-2";          # Grid view.
			"alt.b"        = "A-up";         # Go back.
			"alt.space"    = "C-l";          # Focus location bar.
			"alt.i"        = "C-S-i";        # Invert selection.
			"alt.v"        = "C-i";          # File info.
			"alt.d"        = "C-S-delete";   # Delete file.
			"alt.s"        = "f2";           # Rename.
			"alt.a"        = "C-S-n";        # Create dir.
			"alt.f"        = "C-f";          # Search dir.
			"alt.r"        = "f5";           # Refresh dir.
		};
	};
}
