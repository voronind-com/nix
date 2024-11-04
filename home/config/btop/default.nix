{
	pkgs,
	lib,
	...
}: let
	config = {
		background_update        = true;
		base_10_sizes            = true;
		check_temp               = true;
		clock_format             = "%X";
		color_theme              = "/usr/share/btop/themes/gruvbox_material_dark.theme";
		cpu_bottom               = false;
		cpu_core_map             = "";
		cpu_graph_lower          = "total";
		cpu_graph_upper          = "total";
		cpu_invert_lower         = true;
		cpu_sensor               = "Auto";
		cpu_single_graph         = false;
		custom_cpu_name          = "";
		custom_gpu_name0         = "";
		custom_gpu_name1         = "";
		custom_gpu_name2         = "";
		custom_gpu_name3         = "";
		custom_gpu_name4         = "";
		custom_gpu_name5         = "";
		disk_free_priv           = false;
		disks_filter             = "exclude = /boot /boot/efi";
		force_tty                = false;
		gpu_mirror_graph         = true;
		graph_symbol             = "braille";
		graph_symbol_cpu         = "default";
		graph_symbol_gpu         = "default";
		graph_symbol_mem         = "default";
		graph_symbol_net         = "default";
		graph_symbol_proc        = "default";
		io_graph_combined        = false;
		io_graph_speeds          = "";
		io_mode                  = false;
		log_level                = "WARNING";
		mem_below_net            = false;
		mem_graphs               = true;
		net_auto                 = true;
		net_download             = 100;
		net_iface                = "";
		net_sync                 = true;
		net_upload               = 100;
		nvml_measure_pcie_speeds = true;
		only_physical            = true;
		presets                  = "";
		proc_aggregate           = true;
		proc_colors              = true;
		proc_cpu_graphs          = true;
		proc_filter_kernel       = true;
		proc_gradient            = false;
		proc_info_smaps          = false;
		proc_left                = true;
		proc_mem_bytes           = true;
		proc_per_core            = true;
		proc_reversed            = false;
		proc_sorting             = "memory";
		proc_tree                = true;
		rounded_corners          = true;
		selected_battery         = "Auto";
		show_battery             = true;
		show_coretemp            = true;
		show_cpu_freq            = true;
		show_disks               = true;
		show_gpu_info            = "Auto";
		show_io_stat             = true;
		show_swap                = true;
		show_uptime              = true;
		shown_boxes              = "cpu mem net proc";
		swap_disk                = false;
		temp_scale               = "celsius";
		theme_background         = false;
		truecolor                = true;
		update_ms                = 2000;
		use_fstab                = true;
		vim_keys                 = true;
		zfs_arc_cached           = true;
		zfs_hide_datasets        = false;
	};

	mkOption = k: v: lib.generators.mkKeyValueDefault { } " = " k v;
in {
	file = pkgs.writeText "BtopConfig" (
		builtins.foldl' (acc: line: acc + "${line}\n") "" (
			lib.mapAttrsToList (k: v: let
					value = if builtins.isString v then
						"\"${v}\""
					else if builtins.isBool v then
						if v then "True" else "False"
					else
						v
					;
				in mkOption k value
			) config
		)
	);
}
