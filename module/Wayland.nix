{ pkgs, lib, config, ... }: with lib; let
	cfg = config.module.desktop.wayland;
in {
	options = {
		module.desktop.wayland.enable = mkEnableOption "Wayland.";
	};

	config = {
		programs.xwayland.enable = true;

		environment = {
			systemPackages = with pkgs; [
				wl-clipboard # CLI clipboard support.
			];

			variables = {
				# Compatibility variables.
				ECORE_EVAS_ENGINE                   = "wayland_egl";
				ELM_ENGINE                          = "wayland_egl";
				GDK_BACKEND                         = "wayland";
				MOZ_ENABLE_WAYLAND                  = "1";
				QT_QPA_PLATFORM                     = "wayland-egl;wayland;xcb";
				QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
				SAL_USE_VCLPLUGIN                   = "gtk3";
				SDL_VIDEODRIVER                     = "wayland";
				_JAVA_AWT_WM_NONREPARENTING         = "1";
			};
		};
	};
}
