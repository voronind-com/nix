{ ... }: {
	services.forgejo = {
		enable = true;
		stateDir = "/var/lib/forgejo";

		database = {
			createDatabase = true;
			name = "forgejo";
			type = "postgres";
			user = "forgejo";
		};

		settings = let
			gcArgs = "--aggressive --no-cruft --prune=now";
			gcTimeout = 600;
		in {
			"cron.cleanup_actions".ENABLED = true;
			"cron.update_mirrors".SCHEDULE = "@midnight";
			"git".GC_ARGS    = gcArgs;
			"git.timeout".GC = gcTimeout;
			"log".LEVEL = "Error";
			"repo-archive".ENABLED = false;
			"repository.issue".MAX_PINNED = 99999;
			"repository.pull-request".DEFAULT_MERGE_STYLE = "rebase";
			"service".DISABLE_REGISTRATION = true;
			"server" = {
				DOMAIN    = "git.voronind.com";
				HTTP_ADDR = "0.0.0.0";
				ROOT_URL  = "https://git.voronind.com";
				BUILTIN_SSH_SERVER_USER = "git";
				DISABLE_SSH      = false;
				SSH_PORT         = 22144;
				START_SSH_SERVER = true;
			};
			"ui" = {
				AMBIGUOUS_UNICODE_DETECTION = false;
			};
			"repository" = {
				DEFAULT_PRIVATE = "private";
				DEFAULT_PUSH_CREATE_PRIVATE = true;
			};
			"cron" = {
				ENABLED      = true;
				RUN_AT_START = true;
			};
			"cron.git_gc_repos" = {
				ENABLED  = true;
				ARGS     = gcArgs;
				SCHEDULE = "@midnight";
				TIMEOUT  = gcTimeout;
			};
		};
	};
}
