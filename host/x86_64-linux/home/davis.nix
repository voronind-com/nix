{ config, ... }:
let
  storage = "/data/secret/davis";
in
{
  services.davis = {
    enable = true;
    adminPasswordFile = "${storage}/password";
    appSecretFile = "${storage}/secret";
    hostname = "dav.voronind.com";
    nginx = { };
    mail = {
      dsnFile = "${storage}/dsn";
      inviteFromAddress = "noreply@voronind.com";
    };
  };
}
