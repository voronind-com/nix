{ pkgs, config, ... }:
let
  color = config.module.style.color;
in
{
  # REF: https://github.com/flightlessmango/MangoHud#hud-configuration
  config = (pkgs.formats.iniWithGlobalSection { }).generate "mango-config" {
    globalSection = {
      af = 16;
      blacklist = "example";
      fps_limit = "165,60,55,33,30,0";
      fps_limit_method = "early";
      fps_sampling_period = 1000;
      frame_timing = 0;
      gl_vsync = 0;
      preset = "1,2,3,0";
      toggle_fps_limit = "Shift_L+F2";
      toggle_logging = "Shift_L+F3";
      toggle_preset = "Shift_L+F1";
      vsync = 0;
    };
  };

  presets = (pkgs.formats.ini { }).generate "mango-presets" {
    "preset 0" = {
      no_display = 1;
    };
    "preset 1" = {
      background_alpha = "0.0";
      font_size = 11;
      fps_only = 1;
      hud_no_margin = 1;
      text_color = color.misc;
      text_outline = 0;
    };
    "preset 2" = {
      alpha = 1.0;
      arch = 0;
      background_alpha = 0.5;
      battery = 0;
      battery_time = 1;
      benchmark_percentiles = 0;
      cpu_temp = 1;
      # device_battery = "gamepad,mouse";
      font_size = 12;
      fps_sampling_period = 1000;
      gpu_junction_temp = 0;
      gpu_mem_temp = 1;
      gpu_temp = 1;
      hud_no_margin = 1;
      ram = 0;
      swap = 1;
      throttling_status = 1;
      time = 0;
      vram = 0;
    };
    "preset 3" = {
      full = 1;
    };
  };
}
