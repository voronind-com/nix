{
  config,
  lib,
  pkgs,
  secret,
  ...
}:
let
  cfg = config.module.builder;
  serverKeyPath = "/root/.nixbuilder";
in
{
  config = lib.mkMerge [
    (lib.mkIf cfg.server.enable {
      # Service that generates new key on boot if not present.
      # Don't forget to add new public key to secret.ssh.buildKeys.
      systemd.services.generate-nix-cache-key = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
        path = [ pkgs.nix ];
        script = ''
          [[ -f "${serverKeyPath}/private-key" ]] && exit
          mkdir ${serverKeyPath} || true
          nix-store --generate-binary-cache-key "nixbuilder-1" "${serverKeyPath}/private-key" "${serverKeyPath}/public-key"
          nix store sign --all -k "${serverKeyPath}/private-key"
        '';
      };

      # Add `nixbuilder` restricted user.
      users.groups.nixbuilder = { };
      users.users.nixbuilder = {
        createHome = lib.mkForce false;
        description = "Nix Remote Builder";
        group = "nixbuilder";
        home = "/";
        isNormalUser = true;
        openssh.authorizedKeys.keys = secret.ssh.buildKeys;
        uid = 1234;
      };

      # Sign store automatically.
      # Sign existing store with: nix store sign --all -k /path/to/secret-key-file
      nix.settings = {
        trusted-users = [ "nixbuilder" ];
        secret-key-files = [ "${serverKeyPath}/private-key" ];
      };
    })

    (lib.mkIf cfg.client.enable {
      # NOTE: Requires host public key to be present in secret.ssh.builderKeys.
      nix = {
        distributedBuilds = true;
        buildMachines = [
          {
            hostName = "nixbuilder";
            maxJobs = 4;
            protocol = "ssh-ng";
            speedFactor = 2;
            mandatoryFeatures = [ ];
            systems = [
              "aarch64-linux"
              "i686-linux"
              "x86_64-linux"
            ];
            supportedFeatures = [
              "benchmark"
              "big-parallel"
              "kvm"
              "nixos-test"
            ];
          }
        ];
        settings =
          let
            substituters = [ "ssh-ng://nixbuilder" ];
          in
          {
            builders-use-substitutes = true;
            max-jobs = 0;
            substituters = lib.mkForce substituters;
            trusted-substituters = substituters ++ [ "https://cache.nixos.org/" ];
            trusted-public-keys = [ secret.ssh.builderKey ];
            # require-sigs = false;
            # substitute = false;
          };
      };
    })
  ];
}
