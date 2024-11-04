{
	secret,
	pkgs,
	...
}: {
	file = (pkgs.formats.gitIni { listsAsDuplicateKeys = true; }).generate "GitConfig" {
		gpg.format                 = secret.crypto.sign.git.format;
		gpg.ssh.allowedSignersFile = toString secret.crypto.sign.git.allowed;
		init.defaultBranch         = "main";
		pull.rebase                = true;
		push.autoSetupRemote       = true;
		rebase.autoStash           = true;
		safe.directory             = "*";
		user.signingkey            = builtins.readFile secret.crypto.sign.git.key;
	};
}
