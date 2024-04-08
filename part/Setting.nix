{ ... }: {
	tmux = {
		resize.step = {
			vertical   = "1";
			horizontal = "1";
		};
		status = {
			interval = "2";
			length   = "50";
			battery.threshold = {
				high   = "60";
				medium = "40";
				low    = "20";
				show   = "40";
			};
			volume.threshold = {
				high   = "80";
				medium = "40";
				low    = "10";
				show   = "100";
			};
		};
	};

	nvim = {
		editor = {
			relativenumber = "true";
			indent.default = "2";
		};
		resize.step = {
			vertical   = "2";
			horizontal = "4";
		};
	};

	sway = {
		resize.step = {
			vertical   = "10px";
			horizontal = "10px";
		};
		window = {
			gap = "10";
			opacity.inactive = "0.85";
		};
	};

	foot = {
		font = {
			step = "1";
			dpi  = "yes";
		};
	};

	top.refresh = "2000";

	brightness.step = "10";
	volume.step     = "10";
}