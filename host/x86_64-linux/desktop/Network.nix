{ ... }: {
	networking = {
		firewall.extraCommands = ''
			# Ssh access.
			iptables  -I INPUT -j ACCEPT -s 10.0.0.0/8          -p tcp --dport 22143
			ip6tables -I INPUT -j ACCEPT -s fd09:8d46:0b26::/48 -p tcp --dport 22143

			# Syncthing.
			ip6tables -I INPUT -j ACCEPT -s fd09:8d46:0b26::/48 -p tcp --dport 22000
			ip6tables -I INPUT -j ACCEPT -s fd09:8d46:0b26::/48 -p udp --dport 22000
			ip6tables -I INPUT -j ACCEPT -s fd09:8d46:0b26::/48 -p udp --dport 21027
		'';
	};
}
