{ pkgs, ... }:
{
  # REF: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/yazi.toml
  file = (pkgs.formats.toml { }).generate "yazi-yazi-config" {
    manager = {
      linemode = "none"; # size
      mouse_events = [ ];
      scrolloff = 1;
      show_hidden = false;
      show_symlink = true;
      sort_by = "natural";
      sort_dir_first = false;
      sort_sensitive = false;
      sort_translit = true;
      ratio = [
        1
        4
        3
      ];
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
            run = openWith "mpv --no-video --shuffle";
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
            run = openWith "libreoffice";
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
        pdf = [
          {
            desc = "Pdf";
            orphan = true;
            run = openWith "zathura";
          }
        ];
        switch_install = [
          {
            desc = "Switch Install";
            run = openWith "switch_install";
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

          # Use `file -i file.txt` to find file mime type.
          # Use `xdg-mime query default "text/plain"` to find default app.
          (mkMime "application/pdf" [ "pdf" ])
          (mkMime "application/vnd.oasis.opendocument.*" [ "document" ])
          (mkMime "application/vnd.openxmlformats-officedocument.*" [ "document" ])
          (mkMime "application/vnd.sqlite3" [ "sqlite" ])
          (mkMime "application/x-bittorrent" [ "torrent" ])
          (mkMime "application/x-executable" [ "steam_run" ])
          (mkMime "application/x-pie-executable" [ "steam_run" ])
          (mkMime "audio/*" [ "audio" ])
          (mkMime "image/*" [
            "picture"
            "picture_copy"
            "picture_edit"
            "picture_edit_quick"
          ])
          (mkMime "text/html" [ "browser" ])
          (mkMime "video/*" [ "video" ])

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
