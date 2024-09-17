{ pkgs, pkgsStable, pkgsMaster, ... } @args: {
	core = with pkgs; [
		android-tools     # Android adb tool. Can be used to connect to itself via wireless debugging. binwalk           # Can analyze files for other files inside them.
		bridge-utils      # Network bridges.
		btop htop         # System monitors.
		coreutils         # UNIX Core utilities.
		cryptsetup        # Filesystem encryption (LUKS).
		curl wcurl        # CLI http client.
		ddrescue testdisk # Apps to recover data from drives.
		diffutils         # Diff tool.
		dnsutils          # NS utilities.
		exiftool          # Image info.
		fastfetch         # Systeminfo summary.
		ffmpeg            # Video/audio converter.
		file              # Get general info about a file.
		findutils         # Find tool.
		gawk              # Awk.
		gcc               # C compiler.
		gdu               # TUI storage analyzer.
		git               # Version control system.
		gnugrep           # Grep.
		gnumake           # Make.
		gnused            # Sed.
		gnutar gzip xz    # Archive and compression tools.
		imagemagick       # Image converter and transformation tool.
		inetutils         # Things like FTP.
		iputils           # IP tools.
		jq                # Json parser.
		lm_sensors        # Hardware sensors, like temperature and fan speeds.
		lshw              # Detailed hardware info tool.
		lsof              # Find current file users.
		ltex-ls           # Latex LSP for neovim spellcheck.
		man               # App to read manuals.
		neovim            # Text editor.
		nmap zmap         # Network analyzer.
		openssh sshfs     # Ssh client.
		parallel          # Run programs in parallel.
		parted            # CLI disk partition tool.
		pv                # IO progress bar.
		radare2           # Hex editor.
		ripgrep           # Better grep.
		rsync             # File copy tool.
		smartmontools     # S.M.A.R.T. tools.
		sqlite            # Serverless file-based database engine.
		tmux              # Terminal multiplexor.
		tree              # Show directory stricture as a tree.
		usbutils          # Usb utilities like udiskctl.
		utillinux         # Common Linux utilities.
		ventoy            # Boot multiple ISO/images from a single USB stick.
		wireguard-tools   # Tools to work with Wireguard.
		xray zapret       # FRKN.
		yazi chafa        # CLI file manager.
		yt-dlp            # Video downloader.
		zip unzip         # Zip archive/unarchive tools.

		# (pkgs.callPackage ./ytdlp {})
	];

	desktop = with pkgs; [
		adwaita-icon-theme             # GTK icons.
		foot                           # Terminal emulator.
		fuzzel                         # Application launcher.
		grim slurp wf-recorder swappy  # Screenshot.
		mako                           # Notification system.
		networkmanagerapplet           # Internet configuration.
		pamixer pavucontrol pulseaudio # Audio.
		playerctl                      # Multimedia controls.
		sway waybar                    # Sway WM.

		(pkgs.callPackage ./swayscript args)
	];

	common = with pkgs; [
		evince                # Document viewer.
		chromium              # Just in case I ever need it.
		gimp                  # Image manipulation program.
		gnome-calculator      # Calculator.
		gparted               # GUI disk utility just in case.
		jellyfin-media-player # Jellyfin client (self-hosted Netflix).
		loupe                 # Image viewer.
		nautilus              # File manager.
		obs-studio            # Streaming/recording app.
		onlyoffice-bin        # Office documents app suite.

		(mpv.override { scripts = [ mpvScripts.mpris ]; }) # Media player.
		(pkgs.callPackage ./yamusicdownload {})
	];

	gaming = with pkgs; [
		scanmem # Memory edit tool.
		steam bottles dxvk gamescope mangohud vkd3d wine64 # Gaming!
		steam-run # Run games outside of Steam.
	];

	creative = with pkgs; [
		aseprite    # Pixel Art draw app. WARNING: Always builds from source.
		blender-hip # Blender with HiP support.
		krita       # Draw!
	];

	dev = with pkgs; [
		android-studio
		jetbrains.idea-community
		nixd    # Nix LSP.
	];

	extra = with pkgs; [
		anilibria-winmaclinux       # Anime!
		appimage-run                # Tool to run .AppImage files in NixOS.
		blanket                     # Sounds generator.
		calibre                     # Book library manager.
		cbonsai cmatrix             # CLI Screensavers.
		cowsay lolcat               # CLI funni.
		gnome-font-viewer           # Font viewer.
		p7zip                       # Weird archive tool.
		tor-browser                 # Privacy browser.
		universal-android-debloater # Debloat Android devices.
	];
}
