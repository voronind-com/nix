{
	__findFile,
	config,
	lib,
	pkgs,
	...
} @args: let
	cfg     = config.module.package;
	package = import <package> args;
in {
	config = lib.mkMerge [
		# Core apps.
		(lib.mkIf cfg.core.enable {
			environment.systemPackages = package.core;

			programs = {
				adb.enable = true;
				git.enable = true;
				java = {
					enable  = true;
					package = pkgs.corretto21;
				};
			};
			services = {
				udisks2.enable = true;
			};
		})

		# Common apps.
		(lib.mkIf cfg.common.enable {
			environment.systemPackages = package.common;

			xdg.mime.defaultApplications = {
				# Use `file -i file.txt` to find file mime type.
				# Use `xdg-mime query default "text/plain"` to find default app.
				"application/pdf" = "org.gnome.Evince.desktop";
				"application/vnd.openxmlformats-officedocument.*" = "onlyoffice-desktopeditors.desktop";
				"audio/*" = "mpv.desktop";
				"image/*" = "org.gnome.Loupe.desktop";
				"text/*"  = "nvim.desktop";
				"video/*" = "mpv.desktop";
			};

			services.gvfs.enable = true;

			# Chromium config.
			environment.etc = let
				chromium = import <home/config/chromium> args;
			in {
				"chromium/initial_preferences".source         = lib.mkForce chromium.preferences;
				"chromium/policies/managed/extra.json".source = lib.mkForce chromium.policy;
			};
		})

		# Desktop apps.
		(lib.mkIf cfg.desktop.enable {
			environment.systemPackages = package.desktop;
		})

		# Gaming.
		(lib.mkIf cfg.gaming.enable {
			programs.steam.enable = true;
			environment.systemPackages = package.gaming;
			hardware.graphics = let
				packages = with pkgs; [
					dxvk
					gamescope
					pkgs.mangohud
					vkd3d
				];
			in {
				extraPackages   = packages;
				extraPackages32 = packages;
			};
		})

		# Creative.
		(lib.mkIf cfg.creative.enable {
			environment.systemPackages = package.creative;
		})

		# Development.
		(lib.mkIf cfg.dev.enable {
			environment.systemPackages = package.dev;
		})

		# Extras.
		(lib.mkIf cfg.extra.enable {
			environment.systemPackages = package.extra;
		})
	];
}
