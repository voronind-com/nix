{ pkgs, lib, config, secret, ... }: with lib; let
	cfg = config.module.builder;

	serverKeyPath = "/root/.nixbuilder";
in {
	options = {
		module.builder = {
			server.enable = mkEnableOption "This is a builder server.";
			client.enable = mkEnableOption "This is a builder client.";
		};
	};

	config = mkMerge [
		(mkIf cfg.server.enable {
			# Service that generates new key on boot if not present.
			# Don't forget to add new public key to secret.ssh.buildKeys.
			systemd.services.generate-nix-cache-key = {
				wantedBy = [ "multi-user.target" ];
				serviceConfig.Type = "oneshot";
				path = [ pkgs.nix ];
				script = ''
					[[ -f "${serverKeyPath}/private-key" ]] && exit
					mkdir ${serverKeyPath} || true
					nix-store --generate-binary-cache-key "nixbuilder-1" "${serverKeyPath}/private-key" "${serverKeyPath}/public-key"
					nix store sign --all -k "${serverKeyPath}/private-key"
				'';
			};

			# Add `nixbuilder` restricted user.
			users.groups.nixbuilder = {};
			users.users.nixbuilder = {
				openssh.authorizedKeys.keys = secret.ssh.buildKeys;
				description  = "Nix Remote Builder";
				isNormalUser = true;
				createHome   = lib.mkForce false;
				uid          = 1234;
				home         = "/";
				group        = "nixbuilder";
			};

			# Sign store automatically.
			# Sign existing store with: nix store sign --all -k /path/to/secret-key-file
			nix.settings = {
				trusted-users    = [ "nixbuilder" ];
				secret-key-files = [ "${serverKeyPath}/private-key" ];
			};
		})

		(mkIf cfg.client.enable {
			# NOTE: Requires host public key to be present in secret.ssh.builderKeys.
			nix.buildMachines = [{
				hostName = "nixbuilder";
				protocol = "ssh-ng";
				systems  = [
					"x86_64-linux"
					"i686-linux"
					"aarch64-linux"
				];
				maxJobs     = 16;
				speedFactor = 2;
				mandatoryFeatures = [ ];
				supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
			}];
			nix.distributedBuilds = true;
			nix.settings = let
				substituters = [ "ssh-ng://nixbuilder" ];
			in {
				substituters = mkForce substituters;
				trusted-substituters = substituters ++ [ "https://cache.nixos.org/" ];
				builders-use-substitutes = true;
				max-jobs = 0;
				trusted-public-keys = [ secret.ssh.builderKey ];
				# require-sigs = false;
				# substitute = false;
			};
		})
	];
}
