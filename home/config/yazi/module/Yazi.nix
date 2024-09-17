{ pkgs, config, ... }: {
	file = (pkgs.formats.toml {}).generate "YaziYaziConfig" {
		manager = {
			# linemode       = "mtime";
			mouse_events   = [];
			ratio          = [ 1 4 3 ];
			scrolloff      = 1;
			show_hidden    = false;
			show_symlink   = true;
			sort_by        = "natural";
			sort_dir_first = true;
			sort_sensitive = true;
			sort_translit  = true;
		};

		preview = {
			# image_filter  = "triangle";
			image_filter  = "lanczos3";
			image_quality = 80;
		};

		opener = let
			openWith = app: "${app} \"$@\"";
		in {
			default = [{
				desc   = "Default";
				orphan = true;
				run    = openWith "xdg-open";
			}];
			browser = [{
				desc   = "Browser";
				orphan = true;
				run    = openWith "firefox-esr";
			}];
			text = [{
				desc  = "Text";
				block = true;
				run   = openWith "nvim";
			}];
			audio = [{
				desc   = "Audio";
				orphan = true;
				run    = openWith "mpv --no-video";
			}];
			video = [{
				desc   = "Video";
				orphan = true;
				run    = openWith "mpv";
			}];
			document = [{
				desc   = "Document";
				orphan = true;
				run    = openWith "onlyoffice-desktopeditors";
			}];
			pdf = [{
				desc   = "Pdf";
				orphan = true;
				run    = openWith "evince";
			}];
			image = [{
				desc   = "Image";
				orphan = true;
				run    = openWith "loupe";
			}];
			image_edit = [{
				desc   = "Image Edit";
				orphan = true;
				run    = openWith "gimp";
			}];
			archive = [{
				desc  = "Archive";
				block = true;
				run   = openWith "unpack";
			}];
			hex = [{
				desc  = "Hex";
				block = true;
				run   = openWith "radare2 -c V -w";
			}];
		};

		open = {
			rules = let
				mkRule = mime: use: { inherit mime; use = use ++ [ "text" "hex" ]; };
			in [
				# Use `file -i file.txt` to find file mime type.
				# Use `xdg-mime query default "text/plain"` to find default app.
				(mkRule "application/gzip"            [ "archive" ])
				(mkRule "application/x-tar"           [ "archive" ])
				(mkRule "application/x-xz"            [ "archive" ])
				(mkRule "application/zip"             [ "archive" ])
				(mkRule "application/x-7z-compressed" [ "archive" ])
				(mkRule "application/pdf" [ "pdf" ])
				(mkRule "audio/*" [ "audio" ])
				(mkRule "image/*" [ "image" "image_edit" ])
				(mkRule "video/*" [ "video" ])
				(mkRule "text/html" [ "browser" ])
				(mkRule "application/vnd.openxmlformats-officedocument.*" [ "document" ])
				(mkRule "*" [ ])
			];
		};
	};
}
