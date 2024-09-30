{ const, ... }: {
	time.timeZone      = const.timeZone;
	i18n.defaultLocale = "en_US.UTF-8";

	# You can customize your Locale in detail like that.
	i18n.extraLocaleSettings = {
		LC_ADDRESS        = "ru_RU.UTF-8";
		LC_IDENTIFICATION = "ru_RU.UTF-8";
		LC_MEASUREMENT    = "ru_RU.UTF-8";
		LC_MONETARY       = "ru_RU.UTF-8";
		LC_NAME           = "ru_RU.UTF-8";
		LC_NUMERIC        = "en_GB.UTF-8";
		LC_PAPER          = "ru_RU.UTF-8";
		LC_TELEPHONE      = "ru_RU.UTF-8";
		LC_TIME           = "en_GB.UTF-8";
	};
}
