{ pkgs, config, ... }:
{
  file = (pkgs.formats.toml { }).generate "YaziYaziConfig" {
    manager = {
      # linemode       = "mtime";
      mouse_events = [ ];
      ratio = [
        1
        4
        3
      ];
      scrolloff = 1;
      show_hidden = false;
      show_symlink = true;
      sort_by = "natural";
      sort_dir_first = true;
      sort_sensitive = true;
      sort_translit = true;
    };

    preview = {
      # image_filter  = "triangle";
      image_filter = "lanczos3";
      image_quality = 80;
    };

    opener =
      let
        openWith = app: "${app} \"$@\"";
      in
      {
        default = [
          {
            desc = "Default";
            orphan = true;
            run = openWith "xdg-open";
          }
        ];
        archive = [
          {
            desc = "Archive";
            run = openWith "archive";
          }
        ];
        archive_fast = [
          {
            desc = "Archive Fast";
            run = openWith "archive_fast";
          }
        ];
        audio = [
          {
            desc = "Audio";
            orphan = true;
            run = openWith "mpv --no-video";
          }
        ];
        browser = [
          {
            desc = "Browser";
            orphan = true;
            run = openWith "firefox-esr";
          }
        ];
        document = [
          {
            desc = "Document";
            orphan = true;
            run = openWith "onlyoffice-desktopeditors";
          }
        ];
        hex = [
          {
            desc = "Hex";
            block = true;
            run = openWith "radare2 -c V -w";
          }
        ];
        image = [
          {
            desc = "Image";
            orphan = true;
            run = openWith "loupe";
          }
        ];
        image_edit = [
          {
            desc = "Image Edit";
            orphan = true;
            run = openWith "gimp";
          }
        ];
        mount = [
          {
            desc = "Mount";
            run = openWith "fmount";
          }
        ];
        pdf = [
          {
            desc = "Pdf";
            orphan = true;
            run = openWith "evince";
          }
        ];
        text = [
          {
            desc = "Text";
            block = true;
            run = openWith "nvim";
          }
        ];
        video = [
          {
            desc = "Video";
            orphan = true;
            run = openWith "mpv";
          }
        ];
        unlock = [
          {
            desc = "Unlock";
            block = true;
            run = openWith "funlock";
          }
        ];
        unpack = [
          {
            desc = "Unpack";
            run = openWith "unpack";
          }
        ];
      };

    open = {
      rules =
        let
          defaultUse = [
            "archive"
            "archive_fast"
            "text"
            "hex"
          ];
          mkMime = mime: use: {
            inherit mime;
            use = use ++ defaultUse;
          };
          mkName = name: use: {
            inherit name;
            use = use ++ defaultUse;
          };
        in
        [
          # Use `file -i file.txt` to find file mime type.
          # Use `xdg-mime query default "text/plain"` to find default app.
          (mkMime "application/gzip" [ "unpack" ])
          (mkMime "application/x-tar" [ "unpack" ])
          (mkMime "application/x-xz" [ "unpack" ])
          (mkMime "application/zip" [ "unpack" ])
          (mkMime "application/x-7z-compressed" [ "unpack" ])
          (mkMime "application/x-iso9660-image" [ "mount" ])
          (mkMime "application/x-raw-disk-image" [ "unlock" ])
          (mkMime "application/pdf" [ "pdf" ])
          (mkMime "audio/*" [ "audio" ])
          (mkName "*.mka" [ "audio" ])
          (mkMime "image/*" [
            "image"
            "image_edit"
          ])
          (mkMime "video/*" [ "video" ])
          (mkMime "text/html" [ "browser" ])
          (mkMime "application/vnd.openxmlformats-officedocument.*" [ "document" ])
          (mkMime "*" [ ])
        ];
    };
  };
}
