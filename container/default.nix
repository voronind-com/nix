{
	config,
	lib,
	...
}: let
	cfg = config.container;
in {
	options.container = {
		enable = lib.mkEnableOption "Containers!!";
		autoStart = lib.mkOption {
			default = false;
			type    = lib.types.bool;
		};
		host = lib.mkOption {
			default = "0.0.0.0";
			type    = lib.types.str;
		};
		localAccess = lib.mkOption {
			default = "0.0.0.0";
			type    = lib.types.str;
		};
		storage = lib.mkOption {
			default = "/tmp/container";
			type    = lib.types.str;
		};
		domain = lib.mkOption {
			default = "local";
			type    = lib.types.str;
		};
		interface = lib.mkOption {
			default = "lo";
			type    = lib.types.str;
		};
		media = lib.mkOption {
			default = { };
			type    = lib.types.attrs;
		};
	};

	config = lib.mkIf cfg.enable {
		# This is the network for all the containers.
		# They are not available to the external interface by default,
		# instead they all expose specific ports in their configuration.
		networking = {
			nat = {
				enable = true;
				externalInterface = config.container.interface;
				internalInterfaces = [
					"ve-+"
				];
			};
			networkmanager.unmanaged = [
				"interface-name:ve-*"
			];
		};
	};
}
