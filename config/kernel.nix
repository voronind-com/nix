{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  cfg = config.module.kernel;
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        boot.kernelPackages = pkgsUnstable.linuxPackages;

        boot.kernel.sysctl = {
          # Allow sysrq.
          "kernel.sysrq" = 1;

          # Increase file watchers.
          "fs.inotify.max_user_event" = 9999999;
          "fs.inotify.max_user_instances" = 9999999;
          "fs.inotify.max_user_watches" = 9999999;
          # "fs.file-max" = 999999;
        };
      }

      (lib.mkIf cfg.hardening {
        boot.kernel.sysctl = {
          # Spoof protection.
          "net.ipv4.conf.all.rp_filter" = 1;
          "net.ipv4.conf.default.rp_filter" = 1;

          # Packet forwarding.
          "net.ipv4.ip_forward" = 0;
          "net.ipv6.conf.all.forwarding" = 0;

          # MITM protection.
          "net.ipv4.conf.all.accept_redirects" = 0;
          "net.ipv6.conf.all.accept_redirects" = 0;

          # Do not send ICMP redirects (we are not a router).
          "net.ipv4.conf.all.send_redirects" = 0;

          # Do not accept IP source route packets (we are not a router).
          "net.ipv4.conf.all.accept_source_route" = 0;
          "net.ipv6.conf.all.accept_source_route" = 0;

          # Protect filesystem links.
          "fs.protected_hardlinks" = 0;
          "fs.protected_symlinks" = 0;

          # Lynis config.
          "kernel.core_uses_pid" = 1;
          "kernel.kptr_restrict" = 2;
        };
      })

      (lib.mkIf cfg.hotspotTtlBypass { boot.kernel.sysctl."net.ipv4.ip_default_ttl" = 65; })

      (lib.mkIf cfg.router {
        boot.kernel.sysctl = {
          # Allow spoofing.
          "net.ipv4.conf.all.rp_filter" = lib.mkForce 0;
          "net.ipv4.conf.default.rp_filter" = lib.mkForce 0;

          # Forward packets.
          "net.ipv4.ip_forward" = lib.mkForce 1;
          "net.ipv6.conf.all.forwarding" = lib.mkForce 1;
          "net.ipv4.conf.all.src_valid_mark" = lib.mkForce 1;

          # Allow redirects.
          "net.ipv4.conf.all.accept_redirects" = lib.mkForce 1;
          "net.ipv6.conf.all.accept_redirects" = lib.mkForce 1;

          # Send ICMP.
          "net.ipv4.conf.all.send_redirects" = lib.mkForce 1;

          # Accept IP source route packets.
          "net.ipv4.conf.all.accept_source_route" = lib.mkForce 1;
          "net.ipv6.conf.all.accept_source_route" = lib.mkForce 1;
        };
      })
    ]
  );
}
