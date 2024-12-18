# ThinkPad charge limits.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.module.powerlimit.thinkpad;

  controlFileMax = "/sys/class/power_supply/BAT0/charge_control_end_threshold";
  controlFileMin = "/sys/class/power_supply/BAT0/charge_control_start_threshold";

  script = pkgs.writeShellScriptBin "powerlimit" ''
    function toggle() {
      if status; then
        echo ${toString cfg.offMax} > ${controlFileMax}
        echo ${toString cfg.offMin} > ${controlFileMin}
      else
        echo ${toString cfg.onMin} > ${controlFileMin}
        echo ${toString cfg.onMax} > ${controlFileMax}
      fi

      pkill -RTMIN+6 waybar
      true
    }

    function widget() {
      status && printf '​' || printf ''
    }

    function status() {
      local current=$(cat ${controlFileMax})
      local enabled="${toString cfg.onMax}"

      [[ "''${current}" = "''${enabled}" ]]
    }

    ''${@}
  '';
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ script ];
    systemd = {
      services.powerlimit = {
        enable = true;
        description = "Limit battery charge";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          RemainAfterExit = "yes";
          ExecStart = "${lib.getExe pkgs.bash} -c 'echo ${toString cfg.onMin} > ${controlFileMin}; echo ${toString cfg.onMax} > ${controlFileMax};'";
          ExecStop = "${lib.getExe pkgs.bash} -c 'echo ${toString cfg.offMax} > ${controlFileMax}; echo ${toString cfg.offMin} > ${controlFileMin};'";
        };
      };

      # HACK: Allow user access.
      tmpfiles.rules = [
        "z ${controlFileMax} 0777 - - - -"
        "z ${controlFileMin} 0777 - - - -"
      ];
    };
  };
}
