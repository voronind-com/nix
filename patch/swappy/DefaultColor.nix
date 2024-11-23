{
	config,
	pkgs,
	...
}: let
	color = config.module.style.color;
	accentR = color.accentDecR;
	accentG = color.accentDecG;
	accentB = color.accentDecB;
in {
	file = pkgs.writeText "SwappyDefaultColorPatch" ''
diff --git a/res/style/swappy.css b/res/style/swappy.css
index 66013b3..9c88f84 100644
--- a/res/style/swappy.css
+++ b/res/style/swappy.css
@@ -21,9 +21,9 @@
 }

 .color-box .color-green image {
-  background-color: rgb(0, 255, 0);
+  background-color: rgb(0, 0, 0);
 }

 .color-box .color-blue image {
-  background-color: rgb(0, 0, 255);
+  background-color: rgb(255, 255, 255);
 }
diff --git a/src/application.c b/src/application.c
index 5b98590..5c7e99c 100644
--- a/src/application.c
+++ b/src/application.c
@@ -601,11 +601,11 @@ void color_red_clicked_handler(GtkWidget *widget, struct swappy_state *state) {

 void color_green_clicked_handler(GtkWidget *widget,
                                  struct swappy_state *state) {
-  action_update_color_state(state, 0, 1, 0, 1, false);
+  action_update_color_state(state, 0, 0, 0, 1, false);
 }

 void color_blue_clicked_handler(GtkWidget *widget, struct swappy_state *state) {
-  action_update_color_state(state, 0, 0, 1, 1, false);
+  action_update_color_state(state, 1, 1, 1, 1, false);
 }

 void color_custom_clicked_handler(GtkWidget *widget,
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
