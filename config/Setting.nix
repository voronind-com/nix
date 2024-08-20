# Global settings.
# Just like I can configure each package, here I configure my config! :O)
{ lib, ... }: {
	options.setting = with lib; {
		# Ollama settings.
		# I use the best light model by default.
		ollama = mkOption {
			default = { };
			type = types.submodule {
				# freeformType = lib.jsonFormat.type;
				options = {
					primaryModel = mkOption {
						default = "llama3";
						type    = types.str;
					};
				};
			};
		};

		# Whether to use Dpi-aware setting in supported apps.
		dpiAware = mkOption {
			default = false;
			type    = types.bool;
		};

		# Keyboard options.
		keyboard = mkOption {
			default = { };
			type = types.submodule {
				options = {
					layouts = mkOption {
						default = "us,ru";
						type    = types.str;
					};
					options = mkOption {
						default = "grp:toggle";
						type    = types.str;
					};
				};
			};
		};

		# Zapret params.
		zapret = mkOption {
			default = {};
			type = types.submodule {
				options = {
					params = mkOption {
						default = "--dpi-desync=disorder --dpi-desync-ttl=1 --dpi-desync-split-pos=3";
						type    = types.str;
					};
				};
			};
		};

		# CPU configurations.
		cpu = mkOption {
			default = {};
			type = types.submodule {
				options = {
					hwmon = mkOption {
						default = {};
						type = types.submodule {
							options = {
								path = mkOption {
									default = "";
									type    = types.str;
								};
								file = mkOption {
									default = "";
									type    = types.str;
								};
							};
						};
					};
				};
			};
		};
	};
}
