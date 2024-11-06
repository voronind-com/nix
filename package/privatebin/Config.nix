{
	config,
	pkgs,
	lib,
	util,
	...
}: let
	cfg = {
		main = {
			compression       = "none";
			defaultformatter  = "plaintext";
			discussion        = false;
			email             = true;
			fileupload        = false;
			languageselection = false;
			name              = "voronind pastebin";
			password          = true;
			qrcode            = true;
			sizelimit         = 10 * 1000 * 1000;
			template          = "bootstrap";
		};
		expire = {
			default = "1week";
		};
		formatter_options = {
			markdown           = "Markdown";
			plaintext          = "Plain Text";
			syntaxhighlighting = "Source Code";
		};
		traffic = {
			limit = 10;
		};
		purge = {
			limit = 0;
			batchsize = 10;
		};
		model = {
			class = "Database";
		};
		model_options = {
			"opt[12]" = true;
			dsn = "pgsql:host=${config.container.module.postgres.address};dbname=privatebin";
			pwd = "privatebin";
			tbl = "privatebin_";
			usr = "privatebin";
		};
	};
in {
	file = (pkgs.formats.ini {
		mkKeyValue = with lib.generators; mkKeyValueDefault {
			mkValueString = v: if builtins.isString v then "\"${toString v}\"" else toString v;
		} " = ";
	}).generate "PrivateBinConfig" cfg;
}
