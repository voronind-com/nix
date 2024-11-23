{
	config,
	pkgs,
	...
}: let
	color = config.module.style.color;
	accentR = color.accent-dec-r;
	accentG = color.accent-dec-g;
	accentB = color.accent-dec-b;
in {
	file = pkgs.writeText "SwappyDefaultColorPatch" ''
diff --git a/src/application.c b/src/application.c
index 5b98590..86788b6 100644
--- a/src/application.c
+++ b/src/application.c
@@ -875,9 +875,9 @@ static gboolean is_file_from_stdin(const char *file) {
 }

 static void init_settings(struct swappy_state *state) {
-  state->settings.r = 1;
-  state->settings.g = 0;
-  state->settings.b = 0;
+  state->settings.r = ${accentR};
+  state->settings.g = ${accentG};
+  state->settings.b = ${accentB};
   state->settings.a = 1;
   state->settings.w = state->config->line_size;
   state->settings.t = state->config->text_size;
	'';
}
