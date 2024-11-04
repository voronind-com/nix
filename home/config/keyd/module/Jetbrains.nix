{
	pkgs,
	...
}: {
	file = (pkgs.formats.ini { }).generate "KeydJetbrainsConfig" {
		"jetbrains-*" = {
			"alt./"        = "C-/";          # Toggle comment.
			"alt.."        = "C-f8";         # Toggle line breakpoint.
			"alt.equal"    = "C-A-l";        # Reformat.
			"alt.c"        = "S-escape";     # Close panel.
			"alt.capslock" = "C-A-S-insert"; # New scratch file.
			"alt.q"        = "A-left";       # Prev tab.
			"alt.e"        = "A-right";      # Next tab.
			"alt.x"        = "C-f4";         # Close tab.
			"alt.f"        = "C-S-f";        # Find text.
			"alt.n"        = "C-A-n";        # Find next.
			"alt.g"        = "macro(gd)";    # Go to definition.
			"alt.i"        = "C-i";          # Implement.
			"alt.o"        = "C-o";          # Override.
			"alt.r"        = "S-f10";        # Run.
			"alt.z"        = "C-f2";         # Stop app.
			"alt.d"        = "S-f9";         # Run debugger.
			"alt.a"        = "C-A-5";        # Attach debugger.
			"alt.m"        = "C-A-s";        # Settings.
			"alt.v"        = "C-q";          # Show doc under cursor.
			"alt.s"        = "C-S-A-t";      # Refactor selection.

			"alt.tab" = "timeout(f8, 150, macro2(0, 0, f7))"; # Tap to step over, hold to step into.
		};
	};
}
