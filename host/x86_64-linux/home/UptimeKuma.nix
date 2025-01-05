{ lib, ... }:
{
  services.uptime-kuma = {
    enable = true;
    settings = {
      DATA_DIR = "/var/lib/uptime-kuma/";
      PORT = "64901";
      HOST = "::1";
    };
  };

  systemd.services.uptime-kuma = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
    };
  };
}
