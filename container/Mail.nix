# Guide: https://nixos-mailserver.readthedocs.io/en/latest/setup-guide.html
{ container, pkgs, util, const, lib, config, ... }: with lib; let
	cfg = config.container.module.mail;
	domain = config.container.domain;
in {
	options = {
		container.module.mail = {
			enable = mkEnableOption "Email server.";
			address = mkOption {
				default = "10.1.0.5";
				type    = types.str;
			};
			port = mkOption {
				default = 80;
				type    = types.int;
			};
			domain = mkOption {
				default = "mail.${config.container.domain}";
				type    = types.str;
			};
			storage = mkOption {
				default = "${config.container.storage}/mail";
				type    = types.str;
			};
		};
	};

	config = mkIf cfg.enable {
		systemd.tmpfiles.rules = container.mkContainerDir cfg [
			"data"
			# "data/indices"
			# "data/vmail"
			# "data/sieve"
			# "data/dkim"
		];

		containers.mail = container.mkContainer cfg {
			bindMounts = {
				"/var/lib/dovecot/indices" = {
					hostPath   = "${cfg.storage}/data/indices";
					isReadOnly = false;
				};
				"/var/vmail" = {
					hostPath   = "${cfg.storage}/data/vmail";
					isReadOnly = false;
				};
				"/var/sieve" = {
					hostPath   = "${cfg.storage}/data/sieve";
					isReadOnly = false;
				};
				"/var/dkim" = {
					hostPath   = "${cfg.storage}/data/dkim";
					isReadOnly = false;
				};
				"/acme" = {
					hostPath   = "${config.container.module.proxy.storage}/letsencrypt";
					isReadOnly = true;
				};
			};

			config = { config, ... }: container.mkContainerConfig cfg {
				imports = [
					(builtins.fetchTarball {
						url    = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-${const.stateVersion}/nixos-mailserver-nixos-${const.stateVersion}.tar.gz";
						sha256 = "sha256:0clvw4622mqzk1aqw1qn6shl9pai097q62mq1ibzscnjayhp278b";
					})
				];

				mailserver = {
					enable      = true;
					domains     = [ domain ];
					fqdn        = cfg.domain;
					sendingFqdn = domain;

					# Use `mkpasswd -sm bcrypt`.
					loginAccounts = let
						defaultQuota = "1G";
					in {
						"admin@${domain}" = {
							name = "admin";
							hashedPassword = "$2b$05$1O.dxXxaVshcBNybcqDRYuTlnYt3jDBwfPZWoDtP4BjOLoL0StYsi";
							quota = defaultQuota;
						};
						"account@${domain}" = {
							name = "account";
							hashedPassword = "$2b$05$sCyZHdk98KqQ1qsTIvbrUeRJlNBOwBqDgpdc1QxiSnONlEkZ8xGNO";
							quota = defaultQuota;
						};
						"hi@${domain}" = {
							name = "hi";
							hashedPassword = "$2b$05$6fT5hIhzIasNfp9IQr/ds.5RuxH95VKU3QJWlX3hmrAzDF3mExanq";
							quota = defaultQuota;
							aliases = [ "voronind@${domain}" ];
						};
						"job@${domain}" = {
							name = "job";
							hashedPassword = "$2b$05$.sUmv2.9EWPfLwJn/oZw2e1UbR7HrpNQ2THc5jjX3ysy7CY8ZWHUC";
							quota = defaultQuota;
						};
						"trash@${domain}" = {
							name = "trash";
							hashedPassword = "$2b$05$kn5ygZjN9NR3LXjnKKRw/.DXaZQNW.1XEottlCFIoKiDpIj.JGLJm";
							catchAll = [ domain ];
							quota = defaultQuota;
						};
						"noreply@${domain}" = {
							name = "noreply";
							hashedPassword = "$2b$05$TaKwoYmcmkAhsRRv6xG5wOkChcz50cB9BP6QPUDKNAcxMbrY6AeMK";
							sendOnly = true;
							quota = defaultQuota;
						};
					};

					enableImap          = true;
					enableImapSsl       = true;
					enableSubmission    = true;
					enableSubmissionSsl = true;

					enableManageSieve = true;
					virusScanning     = false;

					certificateScheme = "manual";
					keyFile           = "/acme/live/${domain}/privkey.pem";
					certificateFile   = "/acme/live/${domain}/cert.pem";

					indexDir         = "/var/lib/dovecot/indices";
					mailDirectory    = "/var/vmail";
					sieveDirectory   = "/var/sieve";
					dkimKeyDirectory = "/var/dkim";

					mailboxes = {
						All = {
							auto       = "subscribe";
							specialUse = "All";
						};
						Archive = {
							auto       = "subscribe";
							specialUse = "Archive";
						};
						Drafts = {
							auto       = "subscribe";
							specialUse = "Drafts";
						};
						Junk = {
							auto        = "subscribe";
							specialUse  = "Junk";
							autoexpunge = "7d";
						};
						Sent = {
							auto       = "subscribe";
							specialUse = "Sent";
						};
						Trash = {
							auto        = "subscribe";
							specialUse  = "Trash";
							autoexpunge = "30d";
						};
					};

					dmarcReporting = {
						inherit domain;
						enable = true;
						organizationName = "voronind";
						# email = "noreply@${domain}";
					};

					# monitoring = {
					# 	enable = true;
					# 	alertAddress = "admin@${domain}";
					# };
				};

				services.roundcube = {
					enable = true;
					dicts = with pkgs.aspellDicts; [ en ru ];
					hostName = cfg.domain;
					plugins = [
						"managesieve"
					];
					extraConfig = ''
						# starttls needed for authentication, so the fqdn required to match
						# the certificate
						# $config['smtp_server'] = "tls://${config.mailserver.fqdn}";
						# $config['smtp_server'] = "tls://localhost";
						$config['smtp_server'] = "localhost:25";
						$config['smtp_auth_type'] = null;
						$config['smtp_user'] = "";
						$config['smtp_pass'] = "";
						# $config['smtp_user'] = "%u";
						# $config['smtp_pass'] = "%p";
				 '';
				};

				services.nginx = {
					virtualHosts.${cfg.domain} = {
						forceSSL   = false;
						enableACME = false;
					};
				};
			};
		};
	};
}
