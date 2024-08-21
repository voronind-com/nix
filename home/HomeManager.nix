# This is a common user configuration.
{ const
, util
, config
, lib
, __findFile
, ... } @args: with lib; let
	cfg = config.home.hm;
	package = import <package> args;
in {
	options = {
		home.hm = {
			enable = mkEnableOption "Home-Manager standalone config.";
			username = mkOption {
				default = null;
				type    = types.str;
			};
			homeDirectory = mkOption {
				default = "/home/${cfg.username}";
				type    = types.str;
			};
			package = mkOption {
				default = {};
				type    = types.submodule {
					options = {
						common.enable   = mkEnableOption "Common apps.";
						core.enable     = mkEnableOption "Core apps.";
						creative.enable = mkEnableOption "Creative apps.";
						desktop.enable  = mkEnableOption "Desktop apps.";
						dev.enable      = mkEnableOption "Dev apps.";
						extra.enable    = mkEnableOption "Extra apps.";
						gaming.enable   = mkEnableOption "Gaming apps.";
					};
				};
			};
		};
	};

	config = mkIf cfg.enable (mkMerge [
		{
			home = {
				inherit (cfg) username homeDirectory;
				inherit (const) stateVersion;
				file             = import ./config args;
				sessionVariables = import ./variable args;
			};
			xdg      = import ./xdg { inherit (cfg) homeDirectory; };
			programs = import ./program args;
			dconf.settings = util.catSet (util.ls ./config/dconf) args;
		}
		(mkIf cfg.package.common.enable   { home.packages = package.common;   })
		(mkIf cfg.package.core.enable     { home.packages = package.core;     })
		(mkIf cfg.package.creative.enable { home.packages = package.creative; })
		(mkIf cfg.package.desktop.enable  { home.packages = package.desktop;  })
		(mkIf cfg.package.dev.enable      { home.packages = package.dev;      })
		(mkIf cfg.package.extra.enable    { home.packages = package.extra;    })
		(mkIf cfg.package.gaming.enable   { home.packages = package.gaming;   })
	]);
}
