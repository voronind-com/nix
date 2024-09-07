{ util, ... }: {
	config = util.trimTabs ''
		blacklist=example
		fps_sampling_period=1000
		frame_timing=0
		preset=0,1,2
		toggle_preset=F1
		toggle_logging=F2
	'';

	presets = util.trimTabs ''
		[preset 0]
		no_display=1

		[preset 1]
		alpha=1.0
		arch=0
		background_alpha=0.5
		battery=1
		battery_time=1
		benchmark_percentiles=0
		cpu_temp=1
		device_battery=gamepad,mouse
		font_size=12
		fps_sampling_period=1000
		gpu_junction_temp=1
		gpu_mem_temp=1
		gpu_temp=1
		hud_no_margin=1
		ram=1
		swap=1
		throttling_status=1
		time=1
		vram=1

		[preset 2]
		full=1
	'';
}
