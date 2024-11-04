# This is a common user configuration.
{
	__findFile,
	config,
	const,
	inputs,
	lib,
	pkgs,
	pkgsMaster,
	pkgsStable,
	self,
	...
} @args: let
	cfg = config.home.android;
	android  = import ./android args;
	package  = import <package> args;
	programs = import ./program args;
	stylix   = import <system/Stylix.nix> args;
in {
	options.home.android = {
		enable = lib.mkEnableOption "the Android HM config.";
	};

	config = lib.mkIf cfg.enable {
		environment.packages = package.core;
		time.timeZone = const.timeZone;
		terminal = {
			inherit (android) font colors;
		};
		home-manager.config = stylix // {
			programs = with programs; core;
			imports = [
				inputs.stylix.homeManagerModules.stylix
			];
			home = {
				file = import ./config args;
				sessionVariables = import ./variable args;
				stateVersion     = const.droidStateVersion;
			};
		};
	};
}
