{ config, ... }:
let
  storage = "/data/secret/davis";
in
{
  services.davis = {
    enable = true;
    adminPasswordFile = "${storage}/Password";
    appSecretFile = "${storage}/Secret";
    hostname = "dav.voronind.com";
    nginx = { };
    mail = {
      dsnFile = "${storage}/Dsn";
      inviteFromAddress = "noreply@voronind.com";
    };
  };
}
