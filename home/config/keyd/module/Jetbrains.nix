{ pkgs, ... }: {
	file = (pkgs.formats.ini {}).generate "KeydJetbrainsConfig" {
		"jetbrains-*" = {
			"alt./" = "C-/";
			"alt.=" = "C-A-l";
			"alt.a" = "C-A-5";
			"alt.c" = "S-escape";
			"alt.capslock" = "C-A-S-insert";
			"alt.d" = "S-f9";
			"alt.e" = "A-right";
			"alt.f" = "C-S-f";
			"alt.g" = "macro(gd)";
			"alt.i" = "C-i";
			"alt.n" = "C-A-n";
			"alt.o" = "C-o";
			"alt.q" = "A-left";
			"alt.r" = "S-f10";
			"alt.s" = "C-A-s";
			"alt.tab" = "timeout(f8, 150, macro2(0, 0, f7))";
			"alt.v" = "C-q";
			"alt.w" = "C-S-A-t";
			"alt.x" = "C-f4";
			"alt.z" = "C-f2";
		};
	};
}
