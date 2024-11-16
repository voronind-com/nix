{
	config,
	lib,
	...
}: let
	cfg = config.module.purpose;
in {
	config = lib.mkMerge [
		(lib.mkIf cfg.creativity {
			module = {
				tablet.enable = true;
				package.creativity = true;
			};
		})

		(lib.mkIf cfg.desktop {
			module = {
				keyd.enable = true;
				sway.enable = true;
				kernel = {
					enable = true;
					latest = true;
				};
				package = {
					common  = true;
					core    = true;
					desktop = true;
				};
			};
		})

		(lib.mkIf cfg.disown {
			module = {
				autoupdate.enable = true;
				kernel = {
					enable    = true;
					hardening = true;
				};
			};
		})

		(lib.mkIf cfg.gaming {
			module.package.gaming = true;
		})

		(lib.mkIf cfg.laptop {
			services.tlp.enable = true; # Automatic powersaving based on Pluged/AC states.
			module = {
				keyd.enable = true;
				sway.enable = true;
				kernel = {
					enable    = true;
					hardening = true;
					latest    = true;
				};
				package = {
					common  = true;
					core    = true;
					desktop = true;
				};
			};
		})

		(lib.mkIf cfg.phone {
		})

		(lib.mkIf cfg.router {
			module = {
				kernel = {
					enable    = true;
					hardening = true;
				};
				package = {
					common = true;
					core   = true;
				};
			};
			# De-harden some stuff.
			boot.kernel.sysctl = {
				# Allow spoofing.
				"net.ipv4.conf.all.rp_filter"     = lib.mkForce 0;
				"net.ipv4.conf.default.rp_filter" = lib.mkForce 0;

				# Forward packets.
				"net.ipv4.ip_forward"              = lib.mkForce 1;
				"net.ipv6.conf.all.forwarding"     = lib.mkForce 1;
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

		(lib.mkIf cfg.server {
			module = {
				keyd.enable = true;
				kernel = {
					enable    = true;
					hardening = true;
				};
				package = {
					common = true;
					core   = true;
				};
			};
		})

		(lib.mkIf cfg.work {
			module = {
				distrobox.enable   = true;
				ollama.enable      = true;
				package.dev        = true;
				virtmanager.enable = true;
				docker = {
					enable    = true;
					autostart = false;
					rootless  = false;
				};
				kernel = {
					enable    = true;
					hardening = true;
				};
			};
		})
	];
}
