# Takes pictures from first photo dir, processes and stores to the second one.
{
  util,
  pkgs,
  lib,
  secret,
  ...
}@args:
let
  imgInput = "/storage/hot/container/cloud/data/data/cakee/files/photo";
  imgOutput = "/storage/cold_1/backup/tmp/photo";
in
{
  systemd.services.photosprocess =
    let
      script = pkgs.writeText "PhotoprocessScript" ''
        function notify_silent() {
          curl -X POST -H 'Content-Type: Application/json' -d "${secret.tg.dt "true"}" ${secret.tg.bt} &> /dev/null
        }

        cd ${imgInput}

        # Convert png to jpg.
        for img in $(ls *.png) $(ls *.PNG); do
          filename=''${img%.*}
          convert "$filename.png" "$filename.jpg"
        done
        rm *.png *.PNG

        # Rename bad extensions.
        for img in $(ls *.jpeg) $(ls *.JPG) $(ls *.JPEG); do
          filename=''${img%.*}
          mv "$img" "$filename.jpg"
        done

        # Compress jpg.
        mogrify -resize 2073600@ *.jpg
        jpegoptim --size=1000k *.jpg

        # Rename to hash.
        for file in *; do
          if [[ -f "$file" ]]; then
            extension="''${file##*.}"
            if [ -f "$file" ] && [ "$extension" != "$file" ]; then
              new_name="''${file%$extension}"
            else
              new_name="$file"
              extension=""
            fi
            new_name=$(sha1sum "$file" | cut -d\  -f1)
            if [[ "$extension" != "" ]]; then
              new_name="''${new_name,,}.$extension"
            else
              new_name="''${new_name,,}"
            fi
            mv "$file" "$new_name"
          fi
        done

        # Move to images.
        total_photos=$(ls | wc -l)
        mv *.jpg ${imgOutput}
        notify_silent "Photos processed: $total_photos"
      '';
    in
    util.mkStaticSystemdService {
      enable = true;
      description = "Process uploaded photos.";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "-${lib.getExe pkgs.bashInteractive} ${script}";
        Restart = "on-failure";
      };
      path = with pkgs; [
        curl
        imagemagick
        jpegoptim
      ];
    };

  systemd.timers.photosprocess = {
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "photosprocess.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
