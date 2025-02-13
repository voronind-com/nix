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
    target="alpha/backup/data"
    list="alpha/backup/list"
    delta=true

    # Save media list.
    today=$(date +%Y%m%d)
    cd /alpha && find anime game manga movie show study video -type d > "/''${list}/Alpha-''${today}.txt"
    cd /omega && find anime movie show study video -type d > "/''${list}/Omega-''${today}.txt"

    # Get current snapshot.
    source_current=$(zfs list -t snapshot ''${source} | rg daily | cut -d\  -f1 | tail --lines=1 | cut -d@ -f2)
    target_current=$(zfs list -t snapshot ''${target} | rg daily | cut -d\  -f1 | tail --lines=1 | cut -d@ -f2)

    printf "SC=$source_current\n"
    printf "TC=$target_current\n"

    # Replicate.
    if [[ "''${source_current}" = "''${target_current}" ]]; then
      report "💾 Backup snapshots are the same: ''${source_current}"
    else
      zfs send -Ri ''${source}@''${target_current} ''${source}@''${source_current} | zfs receive -o com.sun:auto-snapshot:daily=false -F ''${target} || {
        delta=false
        zfs send -R ''${source}@''${source_current} | zfs receive -o com.sun:auto-snapshot:daily=false -F ''${target}
      }
      report "💾 Backup complete with ''$(''${delta} || printf NO )delta, version ''${source_current}."
    fi

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
      zfs
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
