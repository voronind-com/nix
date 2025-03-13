{ pkgs, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      dispatcherScripts = [
        {
          source = pkgs.writeText "nm-wb-dispatcher" ''
            ${pkgs.procps}/bin/pkill -RTMIN+7 waybar
          '';
        }
      ];
    };
  };

  # NOTE: Debugging.
  # systemd.services."systemd-networkd".environment.SYSTEMD_LOG_LEVEL = "debug";
}
