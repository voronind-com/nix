{
  __findFile,
  pkgs,
  util,
  ...
}@args:
let
  bash = import <home/program/bash> args;
  script = pkgs.writeText "backup-script" ''
    source ${bash.modulesFile}

    function report() {
      echo "''${*}"
      notify "''${*}"
    }

    # Define constants.
    path_src="/storage/hot"
    path_mount="/storage/cold_1"
    path_backup="''${path_mount}/backup"
    path_data="''${path_backup}/home"
    path_media="/storage/cold_1 /storage/cold_2"

    # Check if backup drive is mounted.
    if [ ! -f "''${path_mount}"/.mount ]; then
      report "Backup: ''${path_mount} not mounted!"
      exit 1
    fi

    # Check if hot storage is mounted.
    if [ ! -f "''${path_src}"/.mount ]; then
      report "Backup: ''${path_src} not mounted!"
      exit 1
    fi

    # Cd to src storage.
    cd "''${path_src}"

    # Save media list.
    find ''${path_media} -type d > ''${path_backup}/cold/ColdMedia.txt || report "Backup: Failed to save media list!"
    cd ''${path_backup}/cold/
    archive ColdMedia.txt && rm ColdMedia.txt || report "Backup: Failed to archive media list!"
    cd -

    # Backup data.
    data=$(archive data/)
    bupsize=$(tdu ''${data} | awk '{print $1}')
    mv ''${data} ''${path_data}/ || report "Backup: Failed to save data!"

    # Backup some media.
    cd ''${path_src}
    paper=$(archive paper/)
    mv ''${paper} ''${path_backup}/paper/ || report "Backup: Failed to save paper!"
    cd -

    rcp_merge ''${path_src}/sync/save/  ''${path_backup}/save/tmp/  || report "Backup: Failed to save game saves!"
    rcp ''${path_src}/sync/photo/ ''${path_backup}/photo/tmp/ || report "Backup: Failed to save photos!"

    # Prune media copies.
    cd ''${path_backup}/paper/
    archive_prune Paper 7
    cd -

    cd ''${path_backup}/cold/
    archive_prune ColdMediaTxt 30
    cd -

    # Prune old data copies.
    cd ''${path_data}
    archive_prune Data 7
    cd -

    # Sync writes.
    sync

    # Notify completion & size.
    notify_silent "Backup: Complete ''${bupsize}."
    echo "Backup: Complete ''${bupsize}."
  '';
in
{
  systemd.services.backup = util.mkStaticSystemdService {
    enable = true;
    description = "Home system backup";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      bashInteractive
      curl
      gawk
      gnutar
      mount
      procps
      pv
      rsync
      xz
    ];
    script = ''
      ${pkgs.bashInteractive}/bin/bash ${script}
    '';
  };

  systemd.timers.backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 06:00:00";
      Persistent = true;
      Unit = "backup.service";
    };
  };
}
