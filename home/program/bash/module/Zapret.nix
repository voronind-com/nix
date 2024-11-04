{ ... }: {
	text = ''
		# FRKN.
		# SOURCE: https://github.com/bol-van/zapret
		function zapret() {
			iptables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 201 --queue-bypass
			nfqws --pidfile=/run/nfqws.pid --qnum=201 ''${@}
		}
	'';
}
