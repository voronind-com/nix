{
  config,
  pkgs,
  util,
  ...
}:
let
  script = ''
    function notify() {
      local bot=$(cat ${config.age.secrets.telegram-notify.path})
      curl -X POST -H 'Content-Type: Application/json' -d "{\"chat_id\":\"155897358\",\"text\":\"$*\",\"disable_notification\":\"true\"}" "$bot" &>/dev/null
    }

    function report() {
      printf "%s\n" "$*"
      notify "$*"
    }

    source="data"
    target="/alpha/backup/home/data"

    # Save media list.
    cd /alpha && find anime game manga movie show study video -type d > "$target/alpha.txt"
    cd /omega && find anime movie show study video -type d > "$target/omega.txt"

    # Get current snapshot.
    source_current=$(zfs list -H -o name -t snapshot $source | tail --lines=1)

    printf "SC=$source_current\n"

    # Replicate.
    zfs send $source_current > "$target/data.zfs"
    size=$(du --si -h --apparent-size "$target/data.zfs")
    report "💾 Backup complete $size with version $source_current."

    # Sync writes.
    zpool sync alpha
  '';
in
{
  systemd.services.backup = util.mkStaticSystemdService {
    inherit script;
    enable = true;
    description = "Home system backup";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      coreutils
      curl
      zfs
    ];
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
