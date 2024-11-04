{
	__findFile,
	config,
	container,
	lib,
	pkgsJobber,
	poetry2nixJobber,
	...
}: let
	cfg = config.container.module.jobber;
	script = import <package/jobber> {
		pkgs       = pkgsJobber;
		poetry2nix = poetry2nixJobber;
	};
in {
	options.container.module.jobber = {
		enable = lib.mkEnableOption "Stanley - the button pusher.";
		address = lib.mkOption {
			default = "10.1.0.32";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "${config.container.storage}/jobber";
			type    = lib.types.str;
		};
	};

	config = lib.mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
		];

		containers.jobber = container.mkContainer cfg {
			bindMounts = {
				"/data" = {
					hostPath   = "${cfg.storage}/data";
					isReadOnly = true;
				};
			};

			enableTun = true;

			config = { ... }: let
				packages = [
					script
				] ++ (with pkgsJobber; [
					firefox
					geckodriver
					openvpn
					python311
				]);
			in container.mkContainerConfig cfg {
				networking = lib.mkForce {
					nameservers = [
						"10.30.218.2"
					];
				};

				systemd.services.jobber = {
					description = "My job is pushing the button.";
					enable = true;
					path = packages;
					wantedBy = [
						"multi-user.target"
					];
					environment = {
						PYTHONDONTWRITEBYTECODE = "1";
						PYTHONUNBUFFERED        = "1";
					};
					serviceConfig = {
						ExecStart = "${script}/bin/jobber -u";
						Restart   = "on-failure";
						Type      = "simple";
					};
				};
			};
		};
	};
}
