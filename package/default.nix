{
  pkgs,
  pkgsStable,
  pkgsMaster,
  ...
}@args:
{
  core = with pkgs; [
    android-tools # Android adb tool. Can be used to connect to itself via wireless debugging. binwalk           # Can analyze files for other files inside them.
    bat # Pretty cat.
    bridge-utils # Network bridges.
    btop # System monitoring.
    chafa # CLI file manager.
    coreutils # UNIX Core utilities.
    cryptsetup # Filesystem encryption (LUKS).
    curl # Http client.
    ddrescue # Data rescue extractor.
    diffutils # Diff tool.
    dnsutils # NS utilities.
    exiftool # Image info.
    fastfetch # Systeminfo summary.
    ffmpeg # Video/audio converter.
    file # Get general info about a file.
    findutils # Find tool.
    gawk # Awk.
    gcc # C compiler.
    gdu # TUI storage analyzer.
    git # Version control system.
    gnugrep # Grep.
    gnumake # Make.
    gnused # Sed.
    gnutar # Tar.
    gzip # Fast compression.
    htop # System monitors.
    imagemagick # Image converter and transformation tool.
    inetutils # Things like FTP.
    iputils # IP tools.
    jq # Json parser.
    lm_sensors # Hardware sensors, like temperature and fan speeds.
    lshw # Detailed hardware info tool.
    lsof # Find current file users.
    ltex-ls # Latex LSP for neovim spellcheck.
    man # App to read manuals.
    neovim # Text editor.
    nmap # Network scanning.
    openssh # Ssh client.
    parallel # Run programs in parallel.
    parted # CLI disk partition tool.
    pv # IO progress bar.
    radare2 # Hex editor.
    ripgrep # Better grep.
    rsync # File copy tool.
    smartmontools # S.M.A.R.T. tools.
    sqlite # Serverless file-based database engine.
    sshfs # Ssh client.
    testdisk # Apps to recover data from drives.
    tmux # Terminal multiplexor.
    tree # Show directory stricture as a tree.
    tree-sitter # A parser generator tool and an incremental parsing library.
    tun2socks # Use proxy as a vpn.
    unzip # Zip archive/unarchive tools.
    usbutils # Usb utilities like udiskctl.
    utillinux # Common Linux utilities.
    ventoy # Boot multiple ISO/images from a single USB stick.
    wcurl # CLI http client.
    wireguard-tools # Tools to work with Wireguard.
    xray # Proxy.
    xz # Archive and compression tools.
    yazi # File manager.
    yt-dlp # Video downloader.
    zapret # FRKN.
    zip # Zip utility.
    zmap # Network analyzer.

    # (pkgs.callPackage ./ytdlp {}) # Youtube downloader bin package.
    (pkgs.callPackage ./yamusicdownload { }) # Yandex music downloader.
  ];

  desktop = with pkgs; [
    adwaita-icon-theme # GTK icons.
    foot # Terminal emulator.
    fuzzel # Application launcher.
    grim # Screenshots.
    slurp # Screen selection.
    wf-recorder # Screen recording.
    swappy # Screenshot editing.
    mako # Notification system.
    networkmanagerapplet # Internet configuration.
    pamixer # Sound controls.
    pavucontrol # Sound applet.
    pulseaudio # Audio.
    playerctl # Multimedia controls.
    sway # Sway WM.
    waybar # Sway bar.

    (pkgs.callPackage ./swayscript args)
  ];

  common = with pkgs; [
    evince # Document viewer.
    chromium # Just in case I ever need it.
    gimp # Image manipulation program.
    gnome-calculator # Calculator.
    gparted # GUI disk utility just in case.
    jellyfin-media-player # Jellyfin client (self-hosted Netflix).
    loupe # Image viewer.
    nautilus # File manager.
    obs-studio # Streaming/recording app.
    onlyoffice-bin # Office documents app suite.

    (mpv.override { scripts = [ mpvScripts.mpris ]; }) # Media player.
  ];

  gaming = with pkgs; [
    scanmem # Memory edit tool.
    steam # Gaming platform.
    bottles # GUI for Wine.
    dxvk # Directx to Vulkan.
    gamescope # Compositor for Steam.
    mangohud # Realtime stats overlay.
    vkd3d # Directx to Vulkan.
    wine64 # Run Windows software on Linux.
    steam-run # Run games outside of Steam.
  ];

  creative = with pkgs; [
    aseprite # Pixel Art draw app. WARNING: Always builds from source.
    blender-hip # Blender with HiP support.
    krita # Draw!
  ];

  dev = with pkgs; [
    android-studio # I hate you.
    jetbrains.idea-community # Okay, but LSP would be better.
  ];

  extra = with pkgs; [
    anilibria-winmaclinux # Anime!
    appimage-run # Tool to run .AppImage files in NixOS.
    blanket # Sounds generator.
    calibre # Book library manager.
    cbonsai # Draw trees.
    cmatrix # CLI Screensavers.
    cowsay # Cow quotes.
    lolcat # CLI funni colors.
    gnome-font-viewer # Font viewer.
    jamesdsp # Active audio processing.
    p7zip # Weird archive tool.
    tor-browser # Privacy browser.
    universal-android-debloater # Debloat Android devices.
  ];
}
