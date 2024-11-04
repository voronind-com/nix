{
	util,
	...
}: let
	mkHost = name: address: port: user: (util.trimTabs ''
		Host ${name}
			HostName ${address}
			User ${user}
			Port ${toString port}
	'');
in {
	text = (util.trimTabs ''
		Host *
			ControlMaster auto
			ControlPath ~/.ssh/%r@%h:%p.socket
			ControlPersist yes
	'')
	+ mkHost "dasha"      "10.0.0.7"       22143 "root"
	+ mkHost "desktop"    "10.0.0.3"       22143 "root"
	+ mkHost "fmpmaven"   "10.30.22.10"    22    "root"
	+ mkHost "home"       "10.0.0.1"       22143 "root"
	+ mkHost "laptop"     "192.168.1.9"    22143 "root"
	+ mkHost "nixbuilder" "10.0.0.1"       22143 "nixbuilder"
	+ mkHost "pi"         "192.168.1.6"    22143 "root"
	+ mkHost "vpn"        "194.113.233.38" 22143 "root"
	+ mkHost "work"       "192.168.1.5"    22143 "root"
	;
}
