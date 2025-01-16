# System automatic updates.
# This is a systemd service that pulls updates every hour.
# Unlike system.autoUpgrade, this script also verifies my git signature
# to prevent unathorized changes to hosts.
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
    programs.git = {
      enable = true;
      config = {
        gpg.ssh.allowedSignersFile = toString secret.crypto.sign.git.allowed;
      };
    };

    systemd.services.autoupdate = util.mkStaticSystemdService {
      enable = true;
      after = [ "network-online.target" ];
      description = "Signed system auto-update.";
      serviceConfig.Type = "oneshot";
      wants = [ "network-online.target" ];
      path = with pkgs; [
        bash
        coreutils
        git
        gnumake
        nixos-rebuild
        openssh
      ];
      script = ''
        pushd /tmp
        rm -rf ./nixos
        git clone --depth=1 --single-branch --branch=main ${config.module.const.url} ./nixos
        pushd ./nixos
        git verify-commit HEAD && git fsck || {
          echo "Verification failed."
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
