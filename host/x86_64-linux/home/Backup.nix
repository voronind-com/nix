{
  __findFile,
  config,
  pkgs,
  util,
  ...
}@args:
let
  bash = import <home/program/bash> args;
  script = pkgs.writeText "backup-script" ''
    source ${bash.modulesFile}

    function report() {
      printf "''${*}\n"
      notify "''${*}"
    }

    source="data"
    target="/alpha/backup/home/data"

    # Save media list.
    cd /alpha && find anime game manga movie show study video -type d > "''${target}/Alpha.txt"
    cd /omega && find anime movie show study video -type d > "''${target}/Omega.txt"

    # Get current snapshot.
    source_current=$(zfs list -H -o name -t snapshot ''${source} | tail --lines=1)

    printf "SC=$source_current\n"

    # Replicate.
    zfs send -R ''${source_current} > "''${target}/Data.zfs"
    size=$(du --si -h "''${target}/Data.zfs")
    report "💾 Backup complete ''${size} with version ''${source_current}."

    # Sync writes.
    zpool sync alpha
  '';
in
{
  systemd.services.backup = util.mkStaticSystemdService {
    enable = true;
    description = "Home system backup";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      bashInteractive
      coreutils
      curl
      ripgrep
      rsync
      zfs
    ];
    script = ''
      ${pkgs.bashInteractive}/bin/bash ${script}
    '';
  };

  systemd.timers.backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 05:05:00";
      Persistent = true;
      Unit = "backup.service";
    };
  };
}
