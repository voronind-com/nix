{
	config,
	lib,
	util,
	...
}: let
	external = "188.242.247.132"; # Wan host IP address.
	internal = "10.0.0.1";        # Lan host IP address.
	wifi     = "10.0.0.2";        # Wifi router IP address.

	lan = "br0";    # Lan interface.
	wan = "enp8s0"; # Wan interface.
in {
	# Allow packet routing (we are a router).
	boot.kernel.sysctl = {
		"net.ipv4.conf.all.src_valid_mark" = lib.mkForce 1;
		"net.ipv4.ip_forward"              = lib.mkForce 1;
	};

	# Disable SSH access from everywhere, configure access bellow.
	services.openssh.openFirewall = false;

	networking = {
		# Use only external DNS.
		networkmanager.insertNameservers = [
			"1.1.1.1"
			"8.8.8.8"
		];

		# Some extra hosts for local access.
		extraHosts = with config.container.module; (util.trimTabs ''
			${git.address} git.voronind.com
			${proxy.address} iot.voronind.com
			${proxy.address} pass.voronind.com
		'');

		firewall = {
			enable = true;
			extraCommands = let
				# Container configs.
				cfg = config.container.module;

				# Const.
				tcp = "tcp";
				udp = "udp";

				# Create port forwarding rule.
				mkForward = src: sport: dst: dport: proto: "iptables -t nat -I PREROUTING -d ${src} -p ${proto} --dport ${toString sport} -j DNAT --to-destination ${dst}:${toString dport}\n";
			in (util.trimTabs ''
				# Wan access for 10.0.0.0/24 subnet.
				iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -d 0/0 -o ${wan} -j MASQUERADE

				# Full access from VPN clients.
				iptables -I INPUT -j ACCEPT -s ${cfg.vpn.address} -d ${internal}
				iptables -I INPUT -j ACCEPT -s ${cfg.frkn.address} -d ${internal}

				# Full access from Lan.
				iptables -I INPUT -j ACCEPT -i ${lan} -d ${internal}
			'')
			# Expose DNS server for internal network.
			+ (mkForward internal cfg.dns.port cfg.dns.address cfg.dns.port tcp)
			+ (mkForward internal cfg.dns.port cfg.dns.address cfg.dns.port udp)

			# Email server.
			+ (mkForward external 25  cfg.mail.address 25  tcp)
			+ (mkForward internal 25  cfg.mail.address 25  tcp)
			+ (mkForward internal 465 cfg.mail.address 465 tcp)
			+ (mkForward internal 993 cfg.mail.address 993 tcp)

			# FRKN internal proxy server.
			+ (mkForward internal cfg.frkn.port     cfg.frkn.address cfg.frkn.port     tcp)
			+ (mkForward internal cfg.frkn.torport  cfg.frkn.address cfg.frkn.torport  tcp)
			+ (mkForward internal cfg.frkn.xrayport cfg.frkn.address cfg.frkn.xrayport tcp)
			+ (mkForward internal cfg.frkn.port     cfg.frkn.address cfg.frkn.port     udp)
			+ (mkForward internal cfg.frkn.torport  cfg.frkn.address cfg.frkn.torport  udp)
			+ (mkForward internal cfg.frkn.xrayport cfg.frkn.address cfg.frkn.xrayport udp)

			# Allow VPN connections from Wan.
			# + (mkForward external cfg.vpn.port cfg.vpn.address cfg.vpn.port udp)

			# Nginx HTTP access from Wan.
			+ (mkForward external cfg.proxy.port cfg.proxy.address cfg.proxy.port tcp)
			+ (mkForward internal cfg.proxy.port cfg.proxy.address cfg.proxy.port tcp)

			# Download ports for torrents.
			+ (mkForward external 54630 cfg.download.address 54630 tcp)
			+ (mkForward external 54631 cfg.download.address 54631 tcp)
			+ (mkForward external 54630 cfg.download.address 54630 udp)
			+ (mkForward external 54631 cfg.download.address 54631 udp)

			# Git ssh connections.
			# + (mkForward external cfg.git.portSsh cfg.git.address cfg.git.portSsh tcp)
			+ (mkForward internal cfg.git.portSsh cfg.git.address cfg.git.portSsh tcp)

			# Print serivce.
			+ (mkForward internal cfg.print.port cfg.print.address cfg.print.port tcp);
		};

		# Create Lan bridge.
		bridges.${lan}.interfaces = [
			"enp6s0f0"
			"enp6s0f1"
			"enp7s0f0"
			"enp7s0f1"
		];

		interfaces = {
			${lan}.ipv4 = {
				# Assign Lan address and subnet.
				addresses = [
					{
						address = internal;
						prefixLength = 24;
					}
				];

				# Assign traffic routes.
				routes = [
					# Wifi 5G clients.
					{
						address      = "192.168.1.0";
						prefixLength = 24;
						via          = wifi;
					}
					# Wifi 2.4G clients.
					{
						address      = "192.168.2.0";
						prefixLength = 24;
						via          = wifi;
					}
				];
			};
		};
	};
}
