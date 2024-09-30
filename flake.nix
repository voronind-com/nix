# This is a configuration entry-point called "Flake".
# Here you define your inputs (dependencies) and outputs (hosts).
{
	# Those are external dependencies.
	inputs = {
		# Core system.
		# Homepage: https://github.com/NixOS/nixpkgs
		# Manual:   https://nixos.org/manual/nixos/stable
		# Search:   https://search.nixos.org/packages and https://search.nixos.org/options
		nixpkgs.url       = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgsMaster.url = "github:nixos/nixpkgs/master";

		# This thing manages user's /home directroies. Because NixOS only manages system itself.
		# Homepage: https://github.com/nix-community/home-manager
		# Manual:   https://nix-community.github.io/home-manager
		# Search:   https://home-manager-options.extranix.com
		home-manager = {
			url = "github:nix-community/home-manager";

			# This means that home-manager and our Flake both depend on the same nixpkgs version.
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# This allows automatic styling based on active Wallpaper.
		# Homepage: https://github.com/danth/stylix
		# Manual:   https://danth.github.io/stylix
		stylix.url  = "github:danth/stylix";

		# I use this for a single container called jobber. WARN: Do not update.
		# You likely won't need this one, so just skip it for now.
		poetry2nixJobber.url = "github:nix-community/poetry2nix/304f8235fb0729fd48567af34fcd1b58d18f9b95";
		nixpkgsJobber.url    = "github:nixos/nixpkgs/051f920625ab5aabe37c920346e3e69d7d34400e";

		# Nix on Android (inside Termux). It has no NixOS modules, but still allows the use of Nixpkgs arm packages with Home-Manager configurations.
		# Homepage: https://github.com/nix-community/nix-on-droid
		# Manual:   https://github.com/nix-community/nix-on-droid/blob/master/README.md
		nix-on-droid = {
			url = "github:t184256/nix-on-droid/release-23.11";
			inputs.nixpkgs.follows      = "nixpkgs";
			inputs.home-manager.follows = "home-manager";
		};

		# Those are Nvim plugins. I do not use package managers like Packer or Lazy, instead I use Nix to download them and later configure in [Neovim module](module/common/Nvim.nix).
		nvimAlign = {
			url   = "github:echasnovski/mini.align";
			flake = false;
		};
		nvimAutoclose = {
			url   = "github:m4xshen/autoclose.nvim";
			flake = false;
		};
		nvimBufferline = {
			url   = "github:akinsho/bufferline.nvim";
			flake = false;
		};
		nvimCloseBuffers = {
			url   = "github:kazhala/close-buffers.nvim";
			flake = false;
		};
		nvimColorizer = {
			url   = "github:brenoprata10/nvim-highlight-colors";
			flake = false;
		};
		nvimDevicons = {
			url   = "github:nvim-tree/nvim-web-devicons";
			flake = false;
		};
		nvimGitsigns = {
			url   = "github:lewis6991/gitsigns.nvim";
			flake = false;
		};
		nvimGruvboxMaterial = {
			url   = "github:sainnhe/gruvbox-material";
			flake = false;
		};
		nvimIndentoMatic = {
			url   = "github:Darazaki/indent-o-matic";
			flake = false;
		};
		nvimLspconfig = {
			url   = "github:neovim/nvim-lspconfig";
			flake = false;
		};
		nvimOllama = {
			url   = "github:nomnivore/ollama.nvim";
			flake = false;
		};
		nvimPlenary = {
			url   = "github:nvim-lua/plenary.nvim";
			flake = false;
		};
		nvimSingleComment = {
			url   = "github:LucasTavaresA/singlecomment.nvim";
			flake = false;
		};
		nvimTelescope = {
			url   = "github:nvim-telescope/telescope.nvim";
			flake = false;
		};
		nvimTodo = {
			url   = "github:folke/todo-comments.nvim";
			flake = false;
		};
		nvimTokyonight = {
			url   = "github:folke/tokyonight.nvim";
			flake = false;
		};
		nvimTransparent = {
			url   = "github:xiyaowong/transparent.nvim";
			flake = false;
		};
		nvimTree = {
			url   = "github:nvim-tree/nvim-tree.lua";
			flake = false;
		};
		nvimTreesitter = {
			url   = "github:nvim-treesitter/nvim-treesitter";
			flake = false;
		};
		nvimTrouble = {
			url   = "github:folke/trouble.nvim";
			flake = false;
		};
	};

	# Those are outputs (hosts, configurations) that can be produced by this whole config.
	# Here you see a set of inputs we defined above, like nixpkgs, home-manager and so on.
	# `...` at the end of a set means "ignore other arguments provided to this function".
	# @inputs means aliasing all the inputs to the `inputs` name, so we can pass them all at once later.
	outputs = { self, nixpkgs, nixpkgsStable, nixpkgsMaster, nix-on-droid, home-manager, stylix, poetry2nixJobber, nixpkgsJobber, ... } @inputs: {
		# Constant values.
		const = {
			droidStateVersion = "23.11";
			stateVersion      = "24.05";
			timeZone = "Europe/Moscow";
			url = "https://git.voronind.com/voronind/nix.git";
		};

		# Hack to use <container/Change.nix> in other files.
		# Need to add __findFile to args tho.
		__findFile = _: p: ./${p};

		# List all files in a dir.
		findFiles = path: map (f: "${path}/${f}") (
			builtins.filter (i: builtins.readFileType "${path}/${i}" == "regular") (
				builtins.attrNames (builtins.readDir path)
			)
		);

		# Nixos systems.
		nixosConfigurations = let
			# Function to create a host. It does basic setup, like adding common modules.
			mkHost = { system, hostname, modules }: nixpkgs.lib.nixosSystem {
				# `Inherit` is just an alias for `system = system;`, which means that
				# keep the `system` argument as a property in a resulting set.
				inherit system;

				# List of modules to use by defualt for all the hosts.
				modules = [
					# Make a device hostname match the one from this config.
					{ networking.hostName = hostname; }

					# Specify current release version.
					{ system.stateVersion = self.const.stateVersion; }

					# Add Home Manager module.
					home-manager.nixosModules.home-manager

					# Add Stylix module.
					stylix.nixosModules.stylix

					# HM config.
					./home/NixOs.nix
				]
				++ modules
				++ (self.findFiles ./host/${system}/${hostname})
				++ (self.findFiles ./config)
				++ (self.findFiles ./container)
				++ (self.findFiles ./module)
				++ (self.findFiles ./system)
				++ (self.findFiles ./overlay);

				# SpecialArgs allows you to pass objects down to other NixOS modules.
				specialArgs = let
					pkgs   = nixpkgs.legacyPackages.${system}.pkgs;
					lib    = nixpkgs.lib;
					config = self.nixosConfigurations.${hostname}.config;
				in {
					inherit inputs self;
					inherit (self) const __findFile;

					pkgsJobber = nixpkgsJobber.legacyPackages.${system}.pkgs;
					pkgsStable = nixpkgsStable.legacyPackages.${system}.pkgs;
					pkgsMaster = nixpkgsMaster.legacyPackages.${system}.pkgs;

					secret    = import ./secret {}; # Secrets (public keys).
					container = import ./lib/Container.nix { inherit lib pkgs config; inherit (self) const; }; # Container utils.
					util      = import ./lib/Util.nix { inherit lib; }; # Util functions.

					# Stuff for Jobber container, skip this part.
					inherit poetry2nixJobber;
				};
			};

			mkSystem = hostname: system: modules: {
				"${hostname}" = mkHost {
					inherit hostname system modules;
				};
			};

			x86System = hostname: mkSystem hostname "x86_64-linux" [];
		in nixpkgs.lib.foldl' (acc: h: acc // h) {} (
			map (host: x86System host) (builtins.attrNames (builtins.readDir ./host/x86_64-linux))
		);


		# Home manager (distro-independent).
		# Install nix: sh <(curl -L https://nixos.org/nix/install) --no-daemon
		# Or with --daemon for multi-user (as root).
		# $ nix run home-manager/master -- init --switch
		# $ nix shell '<home-manager>' -A install
		# Add to /etc/nix/nix.conf > experimental-features = nix-command flakes
		# And then # systemctl restart nix-daemon.service
		# $ home-manager switch --flake ~/hmconf
		homeConfigurations = let
			lib    = nixpkgs.lib;
			secret = import ./secret {};
			util   = import ./lib/Util.nix { inherit lib; };

			mkCommonHome = username: homeDirectory: system: modules: let
				pkgs       = nixpkgs.legacyPackages.${system};
				pkgsStable = nixpkgsStable.legacyPackages.${system};
				pkgsMaster = nixpkgsMaster.legacyPackages.${system};
			in {
				${username} = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;

					extraSpecialArgs = {
						inherit self inputs secret util pkgs pkgsStable pkgsMaster;
						inherit (self) const __findFile;
					};
					modules = [
						./home/HomeManager.nix
						{
							home.hm = {
								inherit username homeDirectory;
								enable = true;
								package = {
									core.enable = true;
								};
							};
						}

						{ nixpkgs.config.allowUnfree = true; }
						{ nixpkgs.config.allowUnfreePredicate = (pkg: true); }
						{ nix.package = pkgs.nix; }
						{ nix.settings.experimental-features = [ "nix-command " "flakes" ]; }

						inputs.stylix.homeManagerModules.stylix
					]
					++ modules
					++ (self.findFiles ./config);
				};
			};

			x86LinuxHome = username: modules: mkCommonHome username "/home/${username}" "x86_64-linux" modules;
			x86LinuxRoot = mkCommonHome "root" "/root" "x86_64-linux" [];
		in nixpkgs.lib.foldl' (acc: h: acc // h) {} [
			x86LinuxRoot
			(x86LinuxHome "voronind" [
				{
					home.hm.package = {
						common.enable = true;
					};
				}
			])
		];

		# Android.
		nixOnDroidConfigurations.default = let
			config = self.nixOnDroidConfigurations.default.config;
			lib    = nixpkgs.lib;
			pkgs   = nixpkgs.legacyPackages."aarch64-linux".pkgs;
		in nix-on-droid.lib.nixOnDroidConfiguration {
			modules = [
				# Android release version.
				{ system.stateVersion = self.const.droidStateVersion; }

				# I put all my Android configuration there.
				./home/Android.nix
				{ home.android.enable = true; }

				# { nixpkgs.config.allowUnfree = true; }
				# { nixpkgs.config.allowUnfreePredicate = (pkg: true); }
				{ nix.extraOptions = "experimental-features = nix-command flakes"; }
				{ home-manager.config.stylix.autoEnable = lib.mkForce false; }

				# Some common modules.
				./config/Setting.nix
				./config/Wallpaper.nix
				(import ./config/Style.nix {
					inherit (config.home-manager) config;
					inherit (self) __findFile;
					inherit lib pkgs;
				})
			];

			# SpecialArgs allows you to pass objects down to other configuration.
			extraSpecialArgs = {
				inherit inputs self;
				inherit (self) const __findFile;

				secret = import ./secret {}; # Secrets (public keys).
				util   = import ./lib/Util.nix { inherit lib; }; # Util functions.
			};
		};
	};
}
# That's it!
