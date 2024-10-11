{ ... }:
{
  text = ''
    # Fix when ethernet mistakenly detects 100 Mb instead of 1000 Mb.
    # SPEED is one of 10/100/1000 etc.
    # Usage: fix_ethernet_speed <DEVICE> <SPEED>
    function fix_ethernet_speed() {
      local device="''${1}"
      local speed="''${2}"

      if [[ "''${device}" = "" || "''${speed}" = "" ]]; then
        help fix_ethernet_speed
        return 2
      fi

      ethtool -s "''${device}" speed "''${speed}"
    }

    # Fix nautilus after typing wrong sftp password.
    function fix_files_sftp() {
      secret-tool clear protocol sftp
    }

    # Delete lost Gradle lock files.
    function fix_gradle_lock() {
      cd "''${HOME}/.gradle" && find -type f | grep \\.lock$ | xargs -- rm
      cd -
    }

    # Fix Gnome's broken RDP ffs.
    # Usage: fix_gnome_rdp <PASSWORD>
    function fix_gnome_rdp() {
      local user="''${USERNAME}"
      local password="''${1}"

      # Check params.
      if [[ "''${password}" = "" ]]; then
        help fix_gnome_rdp
        return 2
      fi

      # Unlock keyring. PROTIP: Disable password for it in password manager.
      pkill -9 -f gnome-keyring-daemon
      echo -n "''${user}" | gnome-keyring-daemon --unlock

      # Generate keys.
      cd /tmp
      openssl genrsa -out rdp-tls.key 4096
      openssl req -new -key rdp-tls.key -subj "/C=US" | openssl x509 -req -days 730 -signkey rdp-tls.key -out rdp-tls.crt
      mkdir -p "''${HOME}/.local/share/gnome-remote-desktop/"
      mv rdp-tls.key rdp-tls.crt "''${HOME}/.local/share/gnome-remote-desktop/"

      # Configure RDP.
      grdctl rdp set-tls-cert "''${HOME}/.local/share/gnome-remote-desktop/rdp-tls.crt"
      grdctl rdp set-tls-key "''${HOME}/.local/share/gnome-remote-desktop/rdp-tls.key"
      grdctl rdp set-credentials "''${user}" "''${password}"
      grdctl rdp disable-view-only

      # Start service.
      grdctl rdp enable
      systemctl --user start gnome-remote-desktop.service

      # Show status.
      grdctl status --show-credentials
      systemctl --user status gnome-remote-desktop.service

      # Show extra info.
      _warn "You may need to manually restart Desktop sharing via Gnome Settings."
    }
  '';
}
