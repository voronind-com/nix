{ pkgs, config, lib, __findFile, ... } @args: with lib; let
	cfg     = config.module.package;
	package = import <package> args;
in {
	options = {
		module.package = {
			common.enable   = mkEnableOption "Common Apps.";
			core.enable     = mkEnableOption "Core apps.";
			creative.enable = mkEnableOption "Creative Apps.";
			desktop.enable  = mkEnableOption "Desktop Apps.";
			dev.enable      = mkEnableOption "Dev Apps.";
			extra.enable    = mkEnableOption "Extra Apps.";
			gaming.enable   = mkEnableOption "Gaming Apps.";
		};
	};

	config = mkMerge [
		# Core apps.
		(mkIf cfg.core.enable {
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
		(mkIf cfg.common.enable {
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

			environment.systemPackages = package.common;

			services.gvfs.enable = true;
		})

		# Desktop apps.
		(mkIf cfg.desktop.enable {
			environment.systemPackages = package.desktop;
		})

		# Gaming.
		(mkIf cfg.gaming.enable {
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

			programs.steam.enable = true;

			environment.systemPackages = package.gaming;
		})

		# Creative.
		(mkIf cfg.creative.enable {
			environment.systemPackages = package.creative;
		})

		# Development.
		(mkIf cfg.dev.enable {
			environment.systemPackages = package.dev;
		})

		# Extras.
		(mkIf cfg.extra.enable {
			environment.systemPackages = package.extra;
		})
	];
}
