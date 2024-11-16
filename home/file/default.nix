{
	config,
	inputs,
	self,
	...
} @args: let
	btop      = import ./btop         args;
	chromium  = import ./chromium     args;
	editor    = import ./editorconfig args;
	foot      = import ./foot         args;
	fuzzel    = import ./fuzzel       args;
	git       = import ./git          args;
	jetbrains = import ./jetbrains    args;
	keyd      = import ./keyd         args;
	mako      = import ./mako         args;
	mangohud  = import ./mangohud     args;
	nvim      = import ./nvim         args;
	ssh       = import ./ssh          args;
	swappy    = import ./swappy       args;
	sway      = import ./sway         args;
	tmux      = import ./tmux         args;
	waybar    = import ./waybar       args;
	yazi      = import ./yazi         args;
in {
	".Wallpaper".source                           = config.module.wallpaper.path;
	".config/MangoHud/MangoHud.conf".source       = mangohud.config;
	".config/MangoHud/presets.conf".source        = mangohud.presets;
	".config/autostart".text                      = "";
	".config/btop/btop.conf".source               = btop.file;
	".config/chromium/Default/Preferences".source = chromium.preferences;
	".config/chromium/Local State".source         = chromium.localState;
	".config/foot/foot.ini".source                = foot.file;
	".config/fuzzel/fuzzel.ini".source            = fuzzel.file;
	".config/keyd/app.conf".text                  = keyd.text;
	".config/mako/config".source                  = mako.file;
	".config/nvim/init.vim".text                  = nvim.text;
	".config/swappy/config".source                = swappy.config;
	".config/sway/config".text                    = sway.text;
	".config/tmux/tmux.conf".text                 = tmux.text;
	".config/waybar/config".source                = waybar.config;
	".config/waybar/style.css".source             = waybar.style;
	".config/yazi/init.lua".source                = yazi.init;
	".config/yazi/keymap.toml".source             = yazi.keymap;
	".config/yazi/theme.toml".source              = yazi.theme;
	".config/yazi/yazi.toml".source               = yazi.yazi;
	".editorconfig".source                        = editor.file;
	".gitconfig".source                           = git.file;
	".ideavimrc".text                             = jetbrains.ideavimrc;
	".nix".source                                 = self;
	".nixpkgs".source                             = inputs.nixpkgs;
	".parallel/will-cite".text                    = "";
	".ssh/config".text                            = ssh.text;
	".template".source                            = ./template;
	# ".nixpkgs_master".source = inputs.nixpkgs;
	# ".nixpkgs_unstable".source = inputs.nixpkgs;
	# TODO: Add after migrating to stable.
}
