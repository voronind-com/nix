{
  lib,
  pkgs,
  const,
  config,
  ...
}:
{
  mkContainer =
    cfg: extra:
    lib.recursiveUpdate {
      # Allow nested containers.
      additionalCapabilities = [ ''all" --system-call-filter="add_key keyctl bpf" --capability="all'' ];
      enableTun = true;

      # Start containers with the system by default.
      autoStart = config.container.autoStart;

      # IP Address of the host. This is required for container to have access to the Internet.
      hostAddress = config.container.host;

      # Container's IP address.
      localAddress = cfg.address;

      # Isolate container from other hosts.
      privateNetwork = true;
    } extra;

  # Common configuration for the system inside the container.
  mkContainerConfig =
    cfg: extra:
    lib.recursiveUpdate {
      boot.isContainer = true;

      # HACK: Do not evaluate nixpkgs inside the container. Use host's instead.
      nixpkgs.pkgs = lib.mkForce pkgs;

      # Release version.
      system.stateVersion = const.stateVersion;

      # Allow passwordless login as root.
      users = {
        users.root.password = "";
        mutableUsers = false;
      };

      networking = {
        # Default DNS servers.
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];

        # HACK: Fix for upstream issue: https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;

        # Configure firewall.
        firewall = {
          enable = true;
          extraCommands = ''
            # Full access from the host.
            iptables -I INPUT -s ${config.container.host} -j ALLOW
          '';
        };
      };
    } extra;

  # Create a directory on the host for container use.
  mkContainerDir = cfg: dirs: map (path: "d '${cfg.storage}/${path}' 1777 root root - -") dirs;

  # Common configuration for Nginx server.
  mkServer = cfg: lib.recursiveUpdate { forceSSL = false; } cfg;

  # Attach the host media directory to container.
  # They will be added to /type/{0..9}
  attachMedia =
    type: ro:
    builtins.listToAttrs (
      lib.imap0 (i: path: {
        name = "/${type}/${toString i}";
        value = {
          hostPath = path;
          isReadOnly = ro;
        };
      }) config.container.media.${type}
    );
}
