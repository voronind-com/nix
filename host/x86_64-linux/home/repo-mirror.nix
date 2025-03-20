{
  __findFile,
  config,
  pkgs,
  secret,
  util,
  ...
}@args:
{
  programs.git = {
    enable = true;
    config = {
      gpg.ssh.allowedSignersFile = toString secret.crypto.sign.git.allowed;
    };
  };

  systemd.services.repo-mirror = util.mkStaticSystemdService {
    enable = true;
    description = "NixOS repo mirror push service";
    serviceConfig.Type = "oneshot";
    environment.GIT_SSH_COMMAND = "ssh -o UserKnownHostsFile=/root/.ssh/known_hosts";
    path = with pkgs; [
      bash
      coreutils
      git
      openssh
    ];
    script = ''
      pushd /tmp
      rm -rf ./nixos-mirror
      git clone --single-branch --branch=main ${config.module.const.url} ./nixos-mirror
      pushd ./nixos-mirror
      git verify-commit HEAD && git fsck || {
        echo "Verification failed."
        exit 1
      };
      git remote add github git@github.com:voronind-com/nix.git
      git remote add codeberg git@codeberg.org:voronind/nix.git
      timeout 10m git push --force github main
      timeout 10m git push --force codeberg main
    '';
  };

  systemd.timers.repo-mirror = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 05:55:00";
      Persistent = true;
      Unit = "repo-mirror.service";
    };
  };
}
