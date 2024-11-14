# This is a common user configuration.
{
	__findFile,
	config,
	const,
	inputs,
	lib,
	pkgs,
	pkgsMaster,
	pkgsUnstable,
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
		home.android.enable  = true;
		nix.extraOptions     = "experimental-features = nix-command flakes";
		system.stateVersion  = const.droidStateVersion;
		time.timeZone        = const.timeZone;
		terminal = {
			inherit (android) font colors;
		};
		home-manager.config = stylix // {
			stylix.autoEnable = lib.mkForce false;
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
