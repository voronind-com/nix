# 10.0.0.0/24    - wired clients (lan).
# 10.1.0.0/24    - containers.
# 10.1.1.0/24    - vpn clients.
# 192.168.1.0/24 - 5G   wireless clients.
# 192.168.2.0/24 - 2.4G wireless clients.
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
	# Disable SSH access from everywhere, configure access bellow.
	services.openssh.openFirewall = false;

	# Wan configuration.
	systemd.network = {
		networks = {
			"10-${wan}" = {
				matchConfig.Name = wan;
				linkConfig.RequiredForOnline = "carrier";
				dhcpV4Config = {
					ClientIdentifier = "mac";
					UseDNS    = false;
					UseRoutes = true;
				};
				dhcpV6Config = {
					DUIDRawData = "00:03:00:01:a8:a1:59:47:fd:a2";
					DUIDType    = "vendor";
					UseDNS      = false;
					WithoutRA   = "solicit";
					# PrefixDelegationHint = "::/56";
				};
				networkConfig = {
					DHCP = "yes";
					DNS  = "1.1.1.1";
					IPv6AcceptRA = true;
					IPv6SendRA   = false;
					DHCPPrefixDelegation = true;
				};
				dhcpPrefixDelegationConfig = {
					UplinkInterface = ":self";
					SubnetId = 0;
					Announce = false;
				};
			};
			"20-enp6s0f0" = {
				linkConfig.RequiredForOnline = "enslaved";
				matchConfig.Name             = "enp6s0f0";
				networkConfig.Bridge         = lan;
			};
			"20-enp6s0f1" = {
				linkConfig.RequiredForOnline = "enslaved";
				matchConfig.Name             = "enp6s0f1";
				networkConfig.Bridge         = lan;
			};
			"20-enp7s0f0" = {
				linkConfig.RequiredForOnline = "enslaved";
				matchConfig.Name             = "enp7s0f0";
				networkConfig.Bridge         = lan;
			};
			"20-enp7s0f1" = {
				linkConfig.RequiredForOnline = "enslaved";
				matchConfig.Name             = "enp7s0f1";
				networkConfig.Bridge         = lan;
			};
			"30-${lan}" = {
				matchConfig.Name = lan;
				bridgeConfig = {};
				linkConfig.RequiredForOnline = "carrier";
				address = [
					"10.0.0.1/24"
				];
				routes = [
					# Wifi 5G clients.
					{
						Destination = "192.168.1.0/24";
						Gateway     = wifi;
					}
					# Wifi 2G clients.
					{
						Destination = "192.168.2.0/24";
						Gateway     = wifi;
					}
				];
				networkConfig = {
					DHCPPrefixDelegation = true;
					IPv6AcceptRA = false;
					IPv6SendRA   = true;
				};
				ipv6SendRAConfig = {
					# EmitDNS = false;
					# DNS = "";
				};
				dhcpPrefixDelegationConfig = {
					UplinkInterface = wan;
					SubnetId = 1;
					Announce = true;
				};
			};
		};

		netdevs = {
			"10-${lan}" = {
				netdevConfig = {
					Kind = "bridge";
					Name = lan;
				};
			};
		};
	};

	networking = {
		firewall = {
			enable = true;
			allowPing = true;
			rejectPackets = false; # Drop.

			logRefusedConnections  = false;
			logReversePathDrops    = false;
			logRefusedPackets      = false;
			logRefusedUnicastsOnly = true;

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
				iptables -I INPUT -j ACCEPT -s ${cfg.vpn.clients} -d ${internal}
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

			# VPN connections.
			+ (mkForward external cfg.vpn.port cfg.vpn.address cfg.vpn.port udp)

			# Nginx HTTP.
			+ (mkForward external cfg.proxy.port cfg.proxy.address cfg.proxy.port tcp)
			+ (mkForward internal cfg.proxy.port cfg.proxy.address cfg.proxy.port tcp)

			# Download ports for torrents.
			+ (mkForward external 54630 cfg.download.address 54630 tcp)
			+ (mkForward external 54631 cfg.download.address 54631 tcp)
			+ (mkForward external 54630 cfg.download.address 54630 udp)
			+ (mkForward external 54631 cfg.download.address 54631 udp)

			# Git SSH connections.
			+ (mkForward external cfg.git.portSsh cfg.git.address cfg.git.portSsh tcp)
			+ (mkForward internal cfg.git.portSsh cfg.git.address cfg.git.portSsh tcp)

			# Print serivce.
			+ (mkForward internal cfg.print.port cfg.print.address cfg.print.port tcp);

			# SSH access from WAN.
			# + (mkForward external 22143 config.container.host 22143 tcp)
		};
	};
}
