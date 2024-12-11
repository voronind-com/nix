{
	pkgs,
	...
}: {
	environment.systemPackages = with pkgs; [
		# SRC: https://github.com/FlyGoat/RyzenAdj
		# ./ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90
		# ryzenAdj --info
		RyzenAdj

		# SRC: https://github.com/nbfc-linux/nbfc-linux
		nbfc-linux
	];
}
