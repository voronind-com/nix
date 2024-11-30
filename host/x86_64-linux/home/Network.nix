# 10.0.0.0/24 - phys clients (lan).
# 10.1.0.0/24 - containers.
# 10.1.1.0/24 - vpn clients.
{
	config,
	const,
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

	# NOTE: Debugging.
	# systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";

	# Wan configuration.
	# REF: https://nixos.wiki/wiki/Systemd-networkd
	# SEE: man 5 systemd.network
	# REF: Wifi config: https://openwrt.org/docs/guide-user/network/wifi/wifiextenders/bridgedap#wireless_access_point_-_dumb_access_point
	systemd.network = {
		enable = true;
		wait-online.enable = false; # HACK: So we can use both NM and networkd.
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
				networkConfig = {
					DHCPPrefixDelegation = true;
					DHCPServer   = true;
					IPv6AcceptRA = false;
					IPv6SendRA   = true;
				};
				ipv6SendRAConfig = {
					# EmitDNS = true;
					# DNS = ":self";
				};
				dhcpPrefixDelegationConfig = {
					Announce = true;
					SubnetId = 1;
					UplinkInterface = wan;
				};
				dhcpServerConfig = {
					DNS                 = "10.0.0.1";
					DefaultLeaseTimeSec = "12h";
					EmitDNS             = true;
					EmitNTP             = true;
					EmitRouter          = true;
					EmitTimezone        = true;
					MaxLeaseTimeSec     = "24h";
					PoolOffset          = 100;
					PoolSize            = 150;
					ServerAddress       = "10.0.0.1/24";
					Timezone            = const.timeZone;
					UplinkInterface     = wan;
				};
				dhcpServerStaticLeases = let
					mkStatic = Address: MACAddress: { dhcpServerStaticLeaseConfig = { inherit Address MACAddress; }; };
				in [
					# TODO: Add pocket.
					(mkStatic "10.0.0.2"  "9c:9d:7e:8e:3d:c7") # Wifi AP.
					(mkStatic "10.0.0.3"  "d8:bb:c1:cc:da:30") # Desktop.
					(mkStatic "10.0.0.4"  "2c:be:eb:52:53:2b") # Phone.
					(mkStatic "10.0.0.5"  "14:85:7f:eb:6c:25") # Work.
					(mkStatic "10.0.0.6"  "08:38:e6:31:54:b6") # Tablet.
					(mkStatic "10.0.0.7"  "2c:f0:5d:3b:07:78") # Dasha.
					(mkStatic "10.0.0.8"  "ac:5f:ea:ef:b5:05") # Dasha phone.
					(mkStatic "10.0.0.9"  "10:b1:df:ea:18:57") # Laptop.
					(mkStatic "10.0.0.10" "9c:1c:37:62:3f:d5") # Printer.
					(mkStatic "10.0.0.11" "dc:a6:32:f5:77:95") # RPi.
					(mkStatic "10.0.0.12" "ec:9c:32:ad:bc:4a") # Camera.
				];
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
		dhcpcd.enable = false;
		useDHCP       = false;
		useNetworkd   = true;
		networkmanager.enable = lib.mkForce false;
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

				# Allow DHCP.
				iptables -I INPUT -j ACCEPT -i ${lan} -p udp --dport 67
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
