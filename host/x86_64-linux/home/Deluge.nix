{ lib, ... }:
{
  services.deluge = {
    enable = true;
    web.enable = true;
  };
  systemd.services.deluged.serviceConfig = {
    MemoryMax = "4G";
    Restart = lib.mkForce "always";
    RuntimeMaxSec = "3h";
  };
}
