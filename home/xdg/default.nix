{ homeDirectory, ... }: {
	userDirs = {
		enable = true;
		createDirectories = true;
		desktop     = "${homeDirectory}/";
		documents   = "${homeDirectory}/document/";
		download    = "${homeDirectory}/download/";
		music       = "${homeDirectory}/music/";
		pictures    = "${homeDirectory}/picture/";
		publicShare = "${homeDirectory}/share/";
		templates   = "${homeDirectory}/template/";
		videos      = "${homeDirectory}/video/";
		extraConfig = {
			XDG_TMP_DIR = "${homeDirectory}/tmp/";
		};
	};
}
