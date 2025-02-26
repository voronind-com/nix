{ pkgs, ... }:
{
  # REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/yazi.toml
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
        audio = [
          {
            desc = "Audio";
            orphan = true;
            run = openWith "mpv --no-video";
          }
        ];
        audio_shuffle = [
          {
            desc = "Audio Shuffle";
            orphan = true;
            run = "mpv --no-video --shuffle \"$@\"/**";
          }
        ];
        bottle_run = [
          {
            desc = "Run bottle";
            run = openWith "btp";
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
        picture = [
          {
            desc = "Picture";
            orphan = true;
            run = openWith "loupe";
          }
        ];
        picture_edit = [
          {
            desc = "Picture Edit";
            orphan = true;
            run = openWith "gimp";
          }
        ];
        picture_edit_quick = [
          {
            desc = "Picture Quick Edit";
            orphan = true;
            run = openWith "pic_edit";
          }
        ];
        picture_copy = [
          {
            desc = "Picture Copy";
            run = openWith "pic_copy";
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
        switch_install = [
          {
            desc = "Switch Install";
            run = openWith "switch_install";
          }
        ];
        shell_run = [
          {
            desc = "Run";
            run = openWith "bash";
          }
        ];
        steam_run = [
          {
            desc = "Run";
            run = openWith "steam-run";
          }
        ];
        sqlite = [
          {
            desc = "Sqlite";
            run = openWith "sqlite3";
          }
        ];
        unlock = [
          {
            desc = "Unlock";
            block = true;
            run = openWith "funlock";
          }
        ];
        text = [
          {
            desc = "Text";
            block = true;
            run = openWith "nvim";
          }
        ];
        torrent = [
          {
            desc = "Download";
            orphan = true;
            run = openWith "tdla";
          }
        ];
        video = [
          {
            desc = "Video";
            orphan = true;
            run = openWith "mpv";
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
          (mkName "*.mka" [ "audio" ])
          (mkName "*.nsp" [ "switch_install" ])
          (mkName "*.nsz" [ "switch_install" ])
          (mkName "*.sh" [ "shell_run" ])
          (mkName "*.xlsx" [ "document" ])

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
          (mkMime "image/*" [
            "picture"
            "picture_copy"
            "picture_edit"
            "picture_edit_quick"
          ])
          (mkMime "video/*" [ "video" ])
          (mkMime "text/html" [ "browser" ])
          (mkMime "application/vnd.openxmlformats-officedocument.*" [ "document" ])
          (mkMime "application/x-executable" [ "steam_run" ])
          (mkMime "application/x-pie-executable" [ "steam_run" ])
          (mkMime "application/x-bittorrent" [ "torrent" ])
          (mkMime "application/vnd.sqlite3" [ "sqlite" ])

          {
            mime = "inode/directory";
            use = [
              "audio_shuffle"
              "bottle_run"
            ];
          }
          (mkMime "*" [ ])
        ];
    };

    which = {
      sort_by = "key";
      sort_sensitive = false;
    };
  };
}
