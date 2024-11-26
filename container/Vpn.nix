# easyrsa --days=36500 init-pki
# easyrsa --days=36500 build-ca
# easyrsa --days=36500 build-server-full <SERVER_NAME> nopass
# easyrsa --days=36500 build-client-full <CLIENT_NAME> nopass
# openssl dhparam -out dh2048.pem 2048
# Don't forget to set tls hostname on the client to match SERVER_NAME *AND* disable ipv6 ?
# SEE: https://github.com/OpenVPN/openvpn/blob/master/sample/sample-config-files/server.conf
# SRC: https://github.com/TinCanTech/easy-tls
{
	config,
	container,
	lib,
	pkgs,
	util,
	...
}: let
	cfg = config.container.module.vpn;
in {
	options.container.module.vpn = {
		enable = lib.mkEnableOption "the vpn server.";
		address = lib.mkOption {
			default = "10.1.0.23";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 22145;
			type    = lib.types.int;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/vpn";
			type    = lib.types.str;
		};
		clients = lib.mkOption {
			default = "10.1.1.0/24";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		# HACK: When using `networking.interfaces.*` it breaks. This works tho.
		systemd.services.vpn-route = util.mkStaticSystemdService {
			enable = true;
			description = "Hack vpn routes on host";
			after    = [ "container@vpn.service" ];
			wants    = [ "container@vpn.service" ];
			wantedBy = [ "multi-user.target" ];
			serviceConfig = {
				ExecStart = "${pkgs.iproute2}/bin/ip route add ${cfg.clients} via ${cfg.address} dev ve-vpn";
				Type      = "oneshot";
			};
		};

		containers.vpn = container.mkContainer cfg {
			bindMounts = {
				"/data" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = true;
				};
			};

			config = { ... }: container.mkContainerConfig cfg {
				boot.kernel.sysctl = {
					"net.ipv4.conf.all.src_valid_mark" = 1;
					"net.ipv4.ip_forward" = 1;
				};
				environment.systemPackages = with pkgs; [
					easyrsa
					openvpn
				];
				users = {
					groups.openvpn = {};
					users.openvpn = {
						group = "openvpn";
						isSystemUser = true;
						uid = 1000;
					};
				};
				# NOTE: Change the `server` to match `cfg.clients` or write a substring here.
				services.openvpn.servers.vpn = {
					autoStart = true;
					config = util.trimTabs ''
						ca /data/pki/ca.crt
						cert /data/pki/issued/home.crt
						client-to-client
						dev tun
						dh /data/dh2048.pem
						explicit-exit-notify 1
						group openvpn
						ifconfig-pool-persist ipp.txt
						keepalive 10 120
						key /data/pki/private/home.key
						persist-tun
						port ${toString cfg.port}
						proto udp
						push "dhcp-option DNS 10.0.0.1"
						push "dhcp-option DNS 10.0.0.1"
						push "route 10.0.0.0 255.0.0.0"
						push "route 192.168.1.0 255.255.255.0"
						server 10.1.1.0 255.255.255.0
						status openvpn-status.log
						topology subnet
						user openvpn
						verb 4
					'';
				};
			};
		};
	};
}
