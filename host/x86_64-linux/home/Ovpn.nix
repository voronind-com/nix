# easyrsa --days=36500 init-pki
# easyrsa --days=36500 build-ca
# easyrsa --days=36500 build-server-full <SERVER_NAME> nopass
# easyrsa --days=36500 build-client-full <CLIENT_NAME> nopass
# easyrsa gen-crl
# openssl dhparam -out dh2048.pem 2048
# Don't forget to set tls hostname on the client to match SERVER_NAME *AND* disable ipv6 ?

# easyrsa revoke <CLIENT_NAME>
# easyrsa gen-crl
# restart container

# SEE: https://github.com/OpenVPN/openvpn/blob/master/sample/sample-config-files/server.conf
# SRC: https://github.com/TinCanTech/easy-tls
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    easyrsa
    openvpn
  ];

  users = {
    groups.openvpn = { };
    users.openvpn = {
      group = "openvpn";
      isSystemUser = true;
      # uid          = 1000;
    };
  };

  # NOTE: Change the `server` to match `cfg.clients` or write a substring here.
  services = {
    openssh.listenAddresses = [
      {
        addr = "10.0.1.1";
        port = 22143;
      }
    ];

    openvpn.servers.vpn = {
      autoStart = true;
      config = ''
        ca /var/lib/ovpn/pki/ca.crt
        cert /var/lib/ovpn/pki/issued/home.crt
        client-to-client
        crl-verify /var/lib/ovpn/pki/crl.pem
        dev tun
        dh /var/lib/ovpn/dh2048.pem
        explicit-exit-notify 1
        group openvpn
        ifconfig-pool-persist ipp.txt
        keepalive 10 120
        key /var/lib/ovpn/pki/private/home.key
        persist-tun
        port 22145
        proto udp
        push "dhcp-option DNS 10.0.0.1"
        push "dhcp-option DNS 10.0.0.1"
        push "route 10.0.0.0 255.0.0.0"
        server 10.0.1.0 255.255.255.0
        status openvpn-status.log
        topology subnet
        user openvpn
        verb 4
      '';
    };
  };
}
