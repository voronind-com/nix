{ pkgs, config, lib, ... }: with lib; let
	cfg = config.module.kernel;
in {
	options = {
		module.kernel = {
			latest = mkOption {
				default = true;
				type    = types.bool;
			};
		};
	};

	config = mkMerge [
		(mkIf cfg.latest {
			# Use latest kernel.
			boot.kernelPackages = pkgs.linuxPackages_latest;
		})

		{
			boot.kernel.sysctl = {
			# 	# Spoof protection.
			# 	"net.ipv4.conf.default.rp_filter" = 1;
			# 	"net.ipv4.conf.all.rp_filter"     = 1;

			# 	# Packet forwarding.
			# 	"net.ipv4.ip_forward" = 0;
			# 	"net.ipv6.conf.all.forwarding" = 1;

			# 	# MITM protection.
			# 	"net.ipv4.conf.all.accept_redirects" = 0;
			# 	"net.ipv6.conf.all.accept_redirects" = 0;

			# 	# Do not send ICMP redirects (we are not a router).
			# 	"net.ipv4.conf.all.send_redirects" = 0;

			# 	# Do not accept IP source route packets (we are not a router).
			# 	"net.ipv4.conf.all.accept_source_route" = 0;
			# 	"net.ipv6.conf.all.accept_source_route" = 0;

				# Allow sysrq.
				"kernel.sysrq" = 1;

			# 	# Protect filesystem links.
			# 	"fs.protected_hardlinks" = 0;
			# 	"fs.protected_symlinks"  = 0;

			# 	# Specify ttl.
			# 	"net.ipv4.ip_default_ttl" = 65;

			# 	# Lynis config.
			# 	"kernel.core_uses_pid" = 1;
			# 	"kernel.kptr_restrict" = 2;

			# 	# IP hardening.
			# 	"net.ipv4.conf.all.log_martians"            = 1;
			# 	"net.ipv4.conf.default.accept_redirects"    = 0;
			# 	"net.ipv4.conf.default.accept_source_route" = 0;
			# 	"net.ipv4.conf.default.log_martians"        = 0;
			# 	"net.ipv4.tcp_timestamps"                   = 0;
			# 	"net.ipv6.conf.default.accept_redirects"    = 0;

				# Increase file watchers.
				"fs.inotify.max_user_instances" = 9999999;
				"fs.inotify.max_user_watches"   = 9999999;
				"fs.inotify.max_user_event"     = 9999999;
				# "fs.file-max"                   = 999999;

			# 	# Disable ipv6.
			# 	"net.ipv6.conf.all.disable_ipv6"     = 1;
			# 	"net.ipv6.conf.default.disable_ipv6" = 1;
			# 	"net.ipv6.conf.lo.disable_ipv6"      = 1;
			# 	"net.ipv6.conf.eth0.disable_ipv6"    = 1;
			};
		}
	];
}
