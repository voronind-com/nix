{ config, ... }: {
	text = ''
		# FRKN.
		function zapret() {
			iptables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
			nfqws --pidfile=/run/nfqws.pid ${config.module.zapret.params} --qnum=200
		}
	'';
}
