{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.module.syncthing;
in {
	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [ syncthing ];
		services.syncthing = {
			inherit (cfg) enable dataDir user group openDefaultPorts;
			systemService = true;
			settings = lib.recursiveUpdate cfg.settings {
				devices = {
					"desktop" = { id = "767Z675-SOCY4FL-JNYEBB6-5E2RG5O-XTZR6OP-BGOBZ7G-XVRLMD6-DQEB2AT"; };
					"home"    = { id = "L5A5IPE-2FPJPHP-RJRV2PV-BLMLC3F-QPHSCUQ-4U3NM2I-AFPOE2A-HOPQZQF"; };
					"phone"   = { id = "6RO5JXW-2XO4S3E-VCDAHPD-4ADK6LL-HQGMZHU-GD6DE2O-6KNHWXJ-BCSBGQ7"; };
				};
				folders = let
					everyone = lib.mapAttrsToList (n: v: n) config.services.syncthing.settings.devices;
				in {
					"save" = {
						path = "${cfg.dataDir}/save";
						devices = [
							"desktop"
							"home"
							# "work"
						];
					};
					"photo" = {
						path = "${cfg.dataDir}/photo";
						devices = [
							"home"
							"phone"
						];
					};
					"tmp" = {
						path = "${cfg.dataDir}/tmp";
						devices = everyone;
					};
					"document" = {
						path = "${cfg.dataDir}/document";
						devices = everyone;
					};
				};
			};
		};
	};
}