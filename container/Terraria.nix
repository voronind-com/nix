{
	config,
	container,
	lib,
	...
}: let
	cfg = config.container.module.terraria;
in {
	options.container.module.terraria = {
		enable = lib.mkEnableOption "the Terraria server.";
		address = lib.mkOption {
			default = "10.1.0.77";
			type    = lib.types.str;
		};
		port = lib.mkOption {
			default = 22777;
			type    = lib.types.int;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/terraria";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.terraria = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/terraria" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = false;
				};
			};

			config = { pkgs, ... }: container.mkContainerConfig cfg {
				# NOTE: Admin with `tmux -S /var/lib/terraria/terraria.sock attach-session -t 0`
				environment.systemPackages = with pkgs; [ tmux ];

				services.terraria = let
					dataDir = "/var/lib/terraria";
				in {
					inherit (cfg) port;
					inherit dataDir;
					enable = true;
					autoCreatedWorldSize = "large";
					maxPlayers      = 4;
					messageOfTheDay = "<3";
					noUPnP          = false;
					openFirewall    = false;
					password        = "mishadima143";
					secure          = false;
					worldPath       = "${dataDir}/.local/share/Terraria/Worlds/Together.wld";
				};
			};
		};
	};
}
