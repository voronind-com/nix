{ pkgs, config, lib, ... }: with lib; let
	cfg = config.module.keyd;
in {
	options = {
		module.keyd = {
			enable = mkEnableOption "Keyboard remaps." // { default = true; };
		};
	};

	config = mkIf cfg.enable {
		environment.systemPackages = with pkgs; [ keyd ];

		services.keyd = {
			enable = true;
			keyboards.default = {
				ids = [ "*" ];
				settings = {
					main = {
						backspace    = "delete";                                   # Delete key on backspace.
						capslock     = "overload(control, esc)";                   # Ctrl/esc combo.
						compose      = "layer(layer_number)";                      # Number input layer.
						esc          = "print";                                    # System controls.
						leftcontrol  = "overload(layer_alternative, leftcontrol)"; # Alternative layer for home, end etc.
						rightcontrol = "layer(layer_control)";                     # Media and other controls.
						rightshift   = "backspace";                                # Backspace.
					};

					# Alternative navigation.
					layer_alternative = {
						w = "pageup";
						a = "home";
						s = "pagedown";
						d = "end";
						x = "cut";
						c = "copy";
						v = "paste";
						h = "left";
						j = "down";
						k = "up";
						l = "right";
						esc = "esc";
						rightcontrol = "leftcontrol";
						capslock = "capslock";
						# space = "macro2(1, 100, macro(space))"; # NOTE: Possible bhop example. Use in per-application, not here.
					};

					# Media controls.
					layer_control = {
						space = "playpause";
						a = "back";
						c = "ejectcd";
						d = "forward";
						e = "nextsong";
						q = "previoussong";
						s = "volumedown";
						w = "volumeup";
						x = "stopcd";
						z = "mute";
					};

					# Number inputs.
					layer_number = {
						q = "1";
						w = "2";
						e = "3";
						a = "4";
						s = "5";
						d = "6";
						z = "7";
						x = "8";
						c = "9";
						space = "0";
						"1" = "f13";
						"2" = "f14";
						"3" = "f15";
						"4" = "f16";
						"5" = "f17";
						"6" = "f18";
						"7" = "f19";
						"8" = "f20";
						"9" = "f21";
						"0" = "f22";
						"-" = "f23";
						"=" = "f24";
						enter = "kpenter";
					};
				};
			};
		};

		# HACK: Workaround for https://github.com/NixOS/nixpkgs/issues/290161
		users.groups.keyd = {};
		systemd.services.keyd.serviceConfig.CapabilityBoundingSet = [ "CAP_SETGID" ];

		# Debug toggle just in case I need it again.
		# systemd.services.keyd.environment.KEYD_DEBUG = "1";
	};
}
