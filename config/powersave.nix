{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.module.powersave;

  script = pkgs.writeShellScriptBin "powersave" ''
    function toggle() {
      if status; then
        echo ${cfg.cpu.boost.disableCmd} > ${cfg.cpu.boost.controlFile}
      else
        echo ${cfg.cpu.boost.enableCmd} > ${cfg.cpu.boost.controlFile}
      fi

      pkill -RTMIN+5 waybar
      true
    }

    function widget() {
      status && printf '​' || printf '󰓅'
    }

    function status() {
      local current=$(cat ${cfg.cpu.boost.controlFile})
      local enabled="${cfg.cpu.boost.enableCmd}"

      [[ "''${current}" = "''${enabled}" ]]
    }

    ''${@}
  '';
in
{
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (cfg.cpu.boost.controlFile != null) {
        environment.systemPackages = [ script ];
        systemd = {
          services.powersave-cpu = {
            enable = true;
            description = "disable CPU Boost";
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
              Type = "simple";
              RemainAfterExit = "yes";
              ExecStart = "${lib.getExe pkgs.bash} -c 'echo ${cfg.cpu.boost.enableCmd} > ${cfg.cpu.boost.controlFile}'";
              ExecStop = "${lib.getExe pkgs.bash} -c 'echo ${cfg.cpu.boost.disableCmd} > ${cfg.cpu.boost.controlFile}'";
            };
          };

          # HACK: Allow user access.
          tmpfiles.rules = [ "z ${cfg.cpu.boost.controlFile} 0777 - - - -" ];
        };
      })

      (lib.mkIf cfg.laptop {
        services = {
          tlp.enable = true;
          upower.enable = true;
        };
      })
    ]
  );
}
