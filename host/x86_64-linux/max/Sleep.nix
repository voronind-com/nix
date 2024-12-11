{
	util,
	...
}: {
	# REF: https://github.com/Sabrina-Fox/WM2-Help#known-wm2-2023-specific-issues-linux
	services.udev.extraRules = util.trimTabs ''
		SUBSYSTEM=="i2c", KERNEL=="i2c-PNP0C50:00", ATTR{power/wakeup}="disabled"
		SUBSYSTEM=="i2c", KERNEL=="i2c-GXTP7385:00", ATTR{power/wakeup}="disabled"
	'';
}
