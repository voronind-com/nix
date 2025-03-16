# System automatic updates.
# This is a systemd service that pulls updates every hour.
# Unlike system.autoUpgrade, this script also verifies my git signature
# to prevent unathorized changes to hosts, and also prevents downgrades.
{
  config,
  lib,
  pkgs,
  secret,
  util,
  ...
}:
let
  cfg = config.module.autoupdate;
in
{
  config = lib.mkIf cfg.enable {
    # This is required to verify the git signature.
    programs.git = {
      enable = true;
      config.gpg.ssh.allowedSignersFile = toString secret.crypto.sign.git.allowed;
    };

    systemd.services.autoupdate = util.mkStaticSystemdService {
      enable = true;
      after = [ "network-online.target" ];
      description = "Signed system auto-update";
      wants = [ "network-online.target" ];
      serviceConfig = {
        # RuntimeMaxSec = "55m"; # NOTE: Doesn't work with oneshot.
        Type = "oneshot";
      };
      path = with pkgs; [
        bash
        coreutils
        git
        gnumake
        jq
        nix
        nixos-rebuild
        openssh
        procps
      ];
      script = ''
        cd /tmp
        rm -rf ./nixos
        git clone --depth=1 --single-branch --branch=main ${config.module.const.url} ./nixos
        cd ./nixos

        git verify-commit HEAD && git fsck || {
          echo "Verification failed."
          exit 1
        };
        version_new=$(nix flake metadata --json | jq .lastModified)
        version_old=$(cat /etc/os-build || echo 0)
        echo "OLD=$version_old NEW=$version_new"
        [[ $version_old -eq 0 ]] && echo "Warning: No old build number!"
        [[ $version_new = $version_old ]] && {
          echo "No updates."
          exit 0
        };
        [[ $version_new -gt $version_old ]] || {
          echo "Downgrade not possible!"
          exit 1
        };

        timeout 55m make switch
      '';
    };

    systemd.timers.autoupdate = {
      enable = true;
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "hourly";
        Persistent = true;
        RandomizedDelaySec = 60;
        Unit = "autoupdate.service";
      };
    };
  };
}
