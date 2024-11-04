{
	lib,
	...
}: {
	"org/gnome/desktop/privacy" = with lib.gvariant; {
		disable-camera            = false;
		disable-microphone        = false;
		old-files-age             = mkUint32 30;
		recent-files-max-age      = mkUint32 30;
		remove-old-temp-files     = true;
		remove-old-trash-files    = true;
		report-technical-problems = true;
	};

	"org/gnome/system/location" = {
		enabled = false;
	};
}
