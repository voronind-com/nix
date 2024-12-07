# 10.0.0.0/24 & fd09:8d46:0b26::/48 - phys clients (lan).
# 10.0.1.0/24 - vpn clients.
{
	config,
	const,
	lib,
	util,
	...
}: let
	internal  = "10.0.0.1"; # Lan host IP address.
	internal6 = "fd09:8d46:b26:0:8079:82ff:fe1a:916a"; # Lan host IP6 address.

	lan = "br0";    # Lan interface.
	wan = "enp8s0"; # Wan interface.
in {
	# Disable SSH access from everywhere, configure access bellow.
	services.openssh.openFirewall = false;

	# Disable systemd-resolved for DNS server.
	services.resolved.enable = false;

	# NOTE: Debugging.
	# systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";

	# Wan configuration.
	# REF: https://nixos.wiki/wiki/Systemd-networkd
	# REF: man 5 systemd.network
	# REF: Wifi config: https://openwrt.org/docs/guide-user/network/wifi/wifiextenders/bridgedap#wireless_access_point_-_dumb_access_point
	systemd.network = {
		enable = true;
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
				linkConfig.RequiredForOnline = "carrier";
				address = [
					"${internal}/24"
					# "${internal6}/48"
				];
				networkConfig = {
					DHCPPrefixDelegation = true;
					DHCPServer   = true;
					IPv6AcceptRA = false;
					IPv6SendRA   = true;
				};
				ipv6SendRAConfig = {
					EmitDNS = true;
					DNS = internal6;
				};
				ipv6Prefixes = [
					{
						Assign = true;
						Prefix = "${internal6}/64";
					}
				];
				dhcpPrefixDelegationConfig = {
					Announce = true;
					SubnetId = 1;
					UplinkInterface = wan;
				};
				dhcpServerConfig = {
					DNS                 = internal;
					DefaultLeaseTimeSec = "12h";
					EmitDNS             = true;
					EmitNTP             = true;
					EmitRouter          = true;
					EmitTimezone        = true;
					MaxLeaseTimeSec     = "24h";
					PoolOffset          = 100;
					PoolSize            = 150;
					ServerAddress       = "${internal}/24";
					Timezone            = const.timeZone;
					UplinkInterface     = wan;
				};
				dhcpServerStaticLeases = let
					mkStatic = Address: MACAddress: { inherit Address MACAddress; };
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

			extraCommands = util.trimTabs ''
				# Wan access for 10.0.0.0/8 subnet.
				iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -d 0/0 -o ${wan} -j MASQUERADE

				# Full access from Lan.
				iptables -I INPUT -j ACCEPT -i ${lan} -d ${internal}
				ip6tables -I INPUT -j ACCEPT -i ${lan} -d ${internal6}

				# Allow DHCP.
				iptables -I INPUT -j ACCEPT -i ${lan} -p udp --dport 67

				# Public email server.
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 25

				# Public VPN service.
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 22145
				iptables -I INPUT -j ACCEPT -s 10.0.1.0/24 -d ${internal}

				# Public Nginx.
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 443

				# Deluge torrenting ports.
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 54630
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 54630
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 54631
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 54631

				# Terraria server.
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 22777

				# Mumble.
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 22666
				ip46tables -I INPUT -j ACCEPT -i ${wan} -p udp --dport 22666

				# Public SSH access.
				# ip46tables -I INPUT -j ACCEPT -i ${wan} -p tcp --dport 22143
			'';
		};
	};
}
