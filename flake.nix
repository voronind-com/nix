{
  inputs = {
    # SOURCE: https://github.com/NixOS/nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # SOURCE: https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SOURCE: https://github.com/nix-community/nix-on-droid
    nix-on-droid = {
      url = "github:t184256/nix-on-droid/release-24.05";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # SOURCE: https://github.com/danth/stylix
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # SOURCE: https://github.com/LilleAila/nix-cursors
    nix-cursors = {
      url = "github:LilleAila/nix-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SOURCE: https://github.com/ryantm/agenix
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        darwin.follows = ""; # NOTE: Disable mac*s support.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nixpkgs-jobber.url = "github:nixos/nixpkgs/051f920625ab5aabe37c920346e3e69d7d34400e";
    poetry2nix-jobber.url = "github:nix-community/poetry2nix/304f8235fb0729fd48567af34fcd1b58d18f9b95";

    nvim-align = {
      flake = false;
      url = "github:echasnovski/mini.align";
    };
    nvim-autoclose = {
      flake = false;
      url = "github:m4xshen/autoclose.nvim";
    };
    nvim-bufferline = {
      flake = false;
      url = "github:akinsho/bufferline.nvim";
    };
    nvim-close-buffers = {
      flake = false;
      url = "github:kazhala/close-buffers.nvim";
    };
    nvim-colorizer = {
      flake = false;
      url = "github:brenoprata10/nvim-highlight-colors";
    };
    nvim-devicons = {
      flake = false;
      url = "github:nvim-tree/nvim-web-devicons";
    };
    nvim-dressing = {
      flake = false;
      url = "github:stevearc/dressing.nvim";
    };
    nvim-git-signs = {
      flake = false;
      url = "github:lewis6991/gitsigns.nvim";
    };
    nvim-gruvbox-material = {
      flake = false;
      url = "github:sainnhe/gruvbox-material";
    };
    nvim-indentomatic = {
      flake = false;
      url = "github:Darazaki/indent-o-matic";
    };
    nvim-lspconfig = {
      flake = false;
      url = "github:neovim/nvim-lspconfig";
    };
    nvim-plenary = {
      flake = false;
      url = "github:nvim-lua/plenary.nvim";
    };
    nvim-telescope = {
      flake = false;
      url = "github:nvim-telescope/telescope.nvim";
    };
    nvim-todo = {
      flake = false;
      url = "github:folke/todo-comments.nvim";
    };
    nvim-tree = {
      flake = false;
      url = "github:nvim-tree/nvim-tree.lua";
    };
    nvim-treesitter = {
      flake = false;
      url = "github:nvim-treesitter/nvim-treesitter";
    };
    nvim-trouble = {
      flake = false;
      url = "github:folke/trouble.nvim";
    };
  };

  outputs =
    {
      agenix,
      home-manager,
      nix-on-droid,
      nixpkgs,
      nixpkgs-jobber,
      nixpkgs-master,
      nixpkgs-unstable,
      poetry2nix-jobber,
      self,
      stylix,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;

      __findFile = _: p: ./${p};

      ls =
        path:
        map (f: "${path}/${f}") (
          builtins.filter (i: builtins.readFileType "${path}/${i}" == "regular") (
            builtins.attrNames (builtins.readDir path)
          )
        );
    in
    {
      devShells =
        let
          pkgs = nixpkgs.legacyPackages.${system};
          system = "x86_64-linux";
        in
        {
          ${system}.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              cloc
              nixd
              nixfmt-rfc-style
              nodePackages.prettier
              nodePackages.prettier-plugin-toml
              shfmt
              stylua
              treefmt
            ];
            # buildInputs = with pkgs; [ ];

            # LD_LIBRARY_PATH   = "${lib.makeLibraryPath buildInputs}";
            # SOURCE_DATE_EPOCH = "${toString self.lastModified}";
          };
        };

      nixosConfigurations =
        let
          mkHost =
            { system, hostname }:
            let
              pkgsJobber = nixpkgs-jobber.legacyPackages.${system}.pkgs;
              pkgs = nixpkgs.legacyPackages.${system}.pkgs;
              pkgsMaster = nixpkgs-master.legacyPackages.${system}.pkgs;
              pkgsUnstable = nixpkgs-unstable.legacyPackages.${system}.pkgs;
              secret = import ./secret { };
              util = import ./lib/util.nix { inherit lib; };
            in
            lib.nixosSystem {
              inherit system;
              modules =
                [
                  # Make a device hostname match the one from this config.
                  { networking.hostName = hostname; }

                  # Home Manager module.
                  home-manager.nixosModules.home-manager

                  # Stylix module.
                  stylix.nixosModules.stylix

                  # Agenix module.
                  agenix.nixosModules.default
                  {
                    environment.systemPackages = [
                      agenix.packages.${system}.default
                      pkgs.age-plugin-yubikey
                    ];
                  }

                  # HM config.
                  ./home/nixos.nix
                ]
                ++ (ls ./host/${system}/${hostname})
                ++ (ls ./option)
                ++ (ls ./config)
                ++ (ls ./overlay)
                ++ (ls ./system);
              specialArgs = {
                inherit
                  __findFile
                  inputs
                  pkgsJobber
                  pkgsMaster
                  pkgsUnstable
                  poetry2nix-jobber
                  secret
                  self
                  util
                  ;
              };
            };

          mkSystem = system: hostname: { "${hostname}" = mkHost { inherit system hostname; }; };

          systems =
            builtins.attrNames (builtins.readDir ./host)
            |> map (system: {
              inherit system;
              hosts = builtins.attrNames (builtins.readDir ./host/${system});
            });

          hosts =
            map (
              system:
              map (host: {
                inherit host;
                inherit (system) system;
              }) system.hosts
            ) systems
            |> lib.foldl' (acc: h: acc ++ h) [ ];

          configurations = map (cfg: mkSystem cfg.system cfg.host) hosts;
        in
        lib.foldl' (result: cfg: result // cfg) { } configurations;

      nixOnDroidConfigurations.default =
        let
          pkgs = nixpkgs.legacyPackages.${system}.pkgs;
          pkgsMaster = nixpkgs-master.legacyPackages.${system}.pkgs;
          pkgsUnstable = nixpkgs-unstable.legacyPackages.${system}.pkgs;
          secret = import ./secret { };
          system = "aarch64-linux";
          util = import ./lib/util.nix { inherit lib; };
        in
        nix-on-droid.lib.nixOnDroidConfiguration {
          inherit pkgs;
          modules = [
            { home.android.enable = true; }
            { home-manager.config.stylix.autoEnable = lib.mkForce false; } # HACK: Broken on Android.
            ./home/android.nix
          ] ++ (ls ./option);
          extraSpecialArgs = {
            inherit
              __findFile
              inputs
              pkgsMaster
              pkgsUnstable
              secret
              self
              util
              ;
          };
        };
    };
}
