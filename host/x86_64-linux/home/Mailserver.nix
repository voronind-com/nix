# REF: https://nixos-mailserver.readthedocs.io/en/latest/setup-guide.html
{
	pkgs,
	util,
	...
}: let
	domain = "voronind.com";

	# SEE: https://gitlab.com/simple-nixos-mailserver/nixos-mailserver#release-branches
	version = "24.05";
	sha256  = "sha256:0clvw4622mqzk1aqw1qn6shl9pai097q62mq1ibzscnjayhp278b";
in {
	imports = [
		(builtins.fetchTarball {
			inherit sha256;
			url    = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-${version}/nixos-mailserver-nixos-${version}.tar.gz";
		})
	];

	mailserver = {
		enable = true;
		domains     = [ domain ];
		fqdn        = "mail.${domain}";
		sendingFqdn = domain;
		localDnsResolver = false;

		# Use `mkpasswd -sm bcrypt`.
		loginAccounts = let
			defaultQuota = "1G";
		in {
			"admin@${domain}" = {
				hashedPassword = "$2b$05$1O.dxXxaVshcBNybcqDRYuTlnYt3jDBwfPZWoDtP4BjOLoL0StYsi";
				name  = "admin";
				quota = defaultQuota;
			};
			"account@${domain}" = {
				hashedPassword = "$2b$05$sCyZHdk98KqQ1qsTIvbrUeRJlNBOwBqDgpdc1QxiSnONlEkZ8xGNO";
				name  = "account";
				quota = defaultQuota;
			};
			"hi@${domain}" = {
				hashedPassword = "$2b$05$6fT5hIhzIasNfp9IQr/ds.5RuxH95VKU3QJWlX3hmrAzDF3mExanq";
				name  = "hi";
				quota = defaultQuota;
				aliases = [
					"voronind@${domain}"
				];
			};
			"job@${domain}" = {
				hashedPassword = "$2b$05$.sUmv2.9EWPfLwJn/oZw2e1UbR7HrpNQ2THc5jjX3ysy7CY8ZWHUC";
				name  = "job";
				quota = defaultQuota;
			};
			"trash@${domain}" = {
				hashedPassword = "$2b$05$kn5ygZjN9NR3LXjnKKRw/.DXaZQNW.1XEottlCFIoKiDpIj.JGLJm";
				name  = "trash";
				quota = defaultQuota;
				catchAll = [
					domain
				];
			};
			"noreply@${domain}" = {
				hashedPassword = "$2b$05$TaKwoYmcmkAhsRRv6xG5wOkChcz50cB9BP6QPUDKNAcxMbrY6AeMK";
				name     = "noreply";
				quota    = defaultQuota;
				sendOnly = true;
			};
		};

		enableImap          = true;
		enableImapSsl       = true;
		enableSubmission    = true;
		enableSubmissionSsl = true;

		enableManageSieve = true;
		virusScanning     = false;

		certificateFile   = "/etc/letsencrypt/live/${domain}/cert.pem";
		certificateScheme = "manual";
		keyFile           = "/etc/letsencrypt/live/${domain}/privkey.pem";

		dkimKeyDirectory = "/var/dkim";
		indexDir         = "/var/lib/dovecot/indices";
		mailDirectory    = "/var/vmail";
		sieveDirectory   = "/var/sieve";

		mailboxes = let
			mkSpecialBox = specialUse: {
				${specialUse} = {
					inherit specialUse;
					auto = "subscribe";
				};
			};
		in builtins.foldl' (acc: box: acc // (mkSpecialBox box)) {} [
			"All"
			"Archive"
			"Drafts"
			"Junk"
			"Sent"
			"Trash"
		];

		dmarcReporting = {
			inherit domain;
			enable = true;
			organizationName = "voronind";
			# email = "noreply@${domain}";
		};

		# monitoring = {
		#   enable = true;
		#   alertAddress = "admin@${domain}";
		# };
	};

	services = {
		roundcube = {
			enable   = true;
			hostName = "mail.${domain}";
			dicts = with pkgs.aspellDicts; [
				en
				ru
			];
			plugins = [
				"managesieve"
			];
			extraConfig = util.trimTabs ''
				$config['smtp_server'] = "localhost:25";
				$config['smtp_auth_type'] = null;
				$config['smtp_user'] = "";
				$config['smtp_pass'] = "";
				# $config['smtp_user'] = "%u";
				# $config['smtp_pass'] = "%p";
			'';
		};
	};

	systemd = {
		services.autoexpunge = {
			description = "Delete old mail";
			serviceConfig = {
				Type = "oneshot";
			};
			path = [
				pkgs.dovecot
			];
			script = util.trimTabs ''
				doveadm expunge -A mailbox Junk SENTBEFORE 7d
				doveadm expunge -A mailbox Trash SENTBEFORE 30d
				doveadm expunge -u trash@voronind.com mailbox Inbox SENTBEFORE 30d
				doveadm purge -A
			'';
		};

		timers.autoexpunge = {
			timerConfig = {
				OnCalendar = "daily";
				Persistent = true;
				Unit       = "autoexpunge.service";
			};
			wantedBy = [
				"timers.target"
			];
		};
	};
}
