{
  inputs,
  pkgs,
  pkgsMaster,
  pkgsUnstable,
  ...
}@args:
{
  core =
    (with pkgs; [
      android-tools # Android adb tool. Can be used to connect to itself via wireless debugging.
      binwalk # Can analyze files for other files inside them.
      bridge-utils # Network bridges.
      btop # System monitoring.
      chafa # CLI file manager.
      coreutils # UNIX Core utilities.
      cryptsetup # Filesystem encryption (LUKS).
      curl # Http client.
      ddrescue # Data rescue extractor.
      diffutils # Diff tool.
      dnsutils # NS utilities.
      ethtool # Ethernet utility.
      exiftool # Image info.
      file # Get general info about a file.
      findutils # Find tool.
      fzf # Find tool.
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
      libjxl # Jpeg XL.
      lm_sensors # Hardware sensors, like temperature and fan speeds.
      lshw # Detailed hardware info tool.
      lsof # Find current file users.
      ltex-ls # Latex LSP for neovim spellcheck.
      man # App to read manuals.
      mtr # Traceroute tool.
      neovim # Text editor.
      nmap # Network scanning.
      openssh # Ssh client.
      openssl # Cryptography.
      openvpn # Vpn client.
      parallel # Run programs in parallel.
      parted # CLI disk partition tool.
      powertop # Monitor power usage.
      pv # IO progress bar.
      qrencode # Generate QR codes.
      radare2 # Hex editor.
      ripgrep # Better grep.
      rsync # File copy tool.
      smartmontools # S.M.A.R.T. tools.
      sqlite # Serverless file-based database engine.
      sshfs # Ssh client.
      tcpdump # Sniff tool.
      testdisk # Apps to recover data from drives.
      tmux # Terminal multiplexor.
      transmission_4 # Torrent client.
      tree # Show directory stricture as a tree.
      tree-sitter # A parser generator tool and an incremental parsing library.
      tun2socks # Use proxy as a vpn.
      ueberzugpp # # Cli draw tool used by Yazi.
      unzip # Zip archive/unarchive tools.
      usbutils # Usb utilities like udiskctl.
      utillinux # Common Linux utilities.
      ventoy # Boot multiple ISO/images from a single USB stick.
      wcurl # CLI http client.
      wireguard-tools # Tools to work with Wireguard.
      xz # Archive and compression tools.
      yazi # File manager.
      zip # Zip utility.

      # (pkgs.callPackage ./ytdlp {}) # Youtube downloader bin package.
    ])
    ++ (with pkgsUnstable; [
      fastfetch # Systeminfo summary.
      ffmpeg # Video/audio converter.
    ])
    ++ (with pkgsMaster; [
      xray # Proxy.
      yt-dlp # Video downloader.
      zapret # FRKN.
    ]);

  desktop = with pkgs; [
    adwaita-icon-theme # GTK icons.
    foot # Terminal emulator.
    fuzzel # Application launcher.
    grim # Screenshots.
    mako # Notification system.
    mpvpaper # Video wallpapers.
    networkmanagerapplet # Internet configuration.
    pamixer # Sound controls.
    pavucontrol # Sound applet.
    playerctl # Multimedia controls.
    pulseaudio # Audio.
    slurp # Screen selection.
    swappy # Screenshot editing.
    sway # Sway WM.
    swaykbdd # Keyboard layout per-window.
    waybar # Sway bar.
    wf-recorder # Screen recording.

    (pkgs.callPackage ./swayscript args)
  ];

  common =
    (with pkgs; [
      evince # Document viewer.
      gimp # Image manipulation program.
      glib # Gnome lib for gvfs mtp usage with Nintendo Switch.
      gnome-calculator # Calculator.
      gparted # GUI disk utility just in case.
      jellyfin-media-player # Jellyfin client (self-hosted Netflix).
      loupe # Image viewer.
      mumble # VoIP.
      obs-studio # Streaming/recording app.
      onlyoffice-bin # Office documents app suite.
      remmina # RDP app.
      upscayl # Image upscaler.

      (mpv.override { scripts = [ mpvScripts.mpris ]; }) # Media player.
    ])
    ++ (with pkgsUnstable; [
      tor-browser # Privacy browser.
    ]);

  gaming = with pkgs; [
    bottles # GUI for Wine.
    dxvk # Directx to Vulkan.
    gamescope # Compositor for Steam.
    mangohud # Realtime stats overlay.
    scanmem # Memory edit tool.
    steam # Gaming platform.
    vkd3d # Directx to Vulkan.
    wine64 # Run Windows software on Linux.

    (import ./steamrun args).pkg # Steam env to run native games.
  ];

  creative = with pkgs; [
    # aseprite # Pixel Art draw app. # WARN: Always builds from source.
    blender-hip # Blender with HiP support.
    krita # Draw!
  ];

  dev = with pkgs; [
    android-studio
    jetbrains.idea-community
  ];

  extra =
    (with pkgs; [
      anilibria-winmaclinux # Anime!
      appimage-run # Tool to run .AppImage files in NixOS.
      blanket # Sounds generator.
      calibre # Book library manager.
      cbonsai # Draw trees.
      cmatrix # CLI Screensavers.
      cowsay # Cow quotes.
      gnome-font-viewer # Font viewer.
      jamesdsp # Active audio processing.
      lolcat # CLI funni colors.
      p7zip # Weird archive tool.
      qpdf # Fix pdfs.
    ])
    ++ (with pkgsUnstable; [
      universal-android-debloater # Debloat Android devices.
    ]);
}
