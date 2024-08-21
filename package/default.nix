{ pkgs, pkgsStable, pkgsMaster, ... } @args: {
	core = with pkgs; [
		android-tools     # Android adb tool. Can be used to connect to itself via wireless debugging.
		binwalk           # Can analyze files for other files inside them.
		bridge-utils      # Network bridges.
		btop htop         # System monitors.
		coreutils         # UNIX Core utilities.
		cryptsetup        # Filesystem encryption (LUKS).
		curl              # CLI http client.
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
		nixd              # Nix LSP.
		nmap              # Network analyzer.
		openssh sshfs     # Ssh client.
		parallel          # Run programs in parallel.
		parted gparted    # GUI/CLI disk partition tool.
		pv                # IO progress bar.
		radare2           # Hex editor.
		ripgrep           # Better grep.
		rsync             # File copy tool.
		scanmem           # Memory edit tool.
		smartmontools     # S.M.A.R.T. tools.
		sqlite            # Serverless file-based database engine.
		tmux              # Terminal multiplexor.
		tree              # Show directory stricture as a tree.
		usbutils          # Usb utilities like udiskctl.
		utillinux         # Common Linux utilities.
		ventoy            # Boot multiple ISO/images from a single USB stick.
		wget              # CLI http download tool.
		wireguard-tools   # Tools to work with Wireguard.
		yazi chafa        # CLI file manager.
		yt-dlp            # Video downloader.
		zapret            # FRKN.
		zip unzip         # Zip archive/unarchive tools.

		(pkgs.callPackage ./yamusicdownload {})
		# (pkgs.callPackage ./ytdlp {})
	];

	desktop = with pkgs; [
		foot                           # Terminal emulator.
		fuzzel                         # Application launcher.
		grim slurp                     # Screenshot.
		mako                           # Notification system.
		networkmanagerapplet           # Internet configuration.
		pamixer pavucontrol pulseaudio # Audio.
		playerctl                      # Multimedia controls.
		sway waybar                    # Sway WM.

		(pkgs.callPackage ./swayscript args)
	];

	common = with pkgs; [
		adwaita-icon-theme    # GTK icons.
		evince                # Document viewer.
		firefox-esr           # Web browser.
		gimp                  # Image manipulation program.
		gnome-calculator      # Calculator.
		nautilus              # File manager.
		jellyfin-media-player # Jellyfin client (self-hosted Netflix).
		loupe                 # Image viewer.
		obs-studio            # Streaming/recording app.
		onlyoffice-bin        # Office documents app suite.

		(mpv.override {scripts = [mpvScripts.mpris];}) # Media player.
	];

	gaming = with pkgs; [
		steam-run # Run games outside of Steam.
		steam bottles dxvk gamescope mangohud vkd3d wine64 # Gaming!
	];

	creative = with pkgs; [
		aseprite    # Pixel Art draw app. WARNING: Always builds from source.
		blender-hip # Blender with HiP support.
		krita       # Draw!
	];

	dev = with pkgs; [
		android-studio
		jetbrains.idea-community
	];

	extra = with pkgs; [
		anilibria-winmaclinux       # Anime!
		appimage-run                # Tool to run .AppImage files in NixOS.
		blanket                     # Sounds generator.
		calibre                     # Book library manager.
		cbonsai cmatrix             # CLI Screensavers.
		cowsay lolcat               # CLI funni.
		gnome-font-viewer           # Font viewer.
		ollama                      # LLMs.
		tor-browser                 # Privacy browser.
		universal-android-debloater # Debloat Android devices.
	];
}
