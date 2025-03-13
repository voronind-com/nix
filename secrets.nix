let
  yubikey = builtins.readFile ./secret/age/yubikey_recepient.key;
  host = (import ./secret { }).network.host;

  mkSecret =
    {
      name,
      hosts,
      extra ? { },
    }:
    {
      "secret/age/${name}.age" = {
        publicKeys = [ yubikey ] ++ (map (host: host.key) hosts);
      } // extra;
    };

  secrets = with host; [
    (mkSecret {
      name = "telegram_notify";
      hosts = [ home ];
    })
    (mkSecret {
      name = "wifi";
      hosts = [
        max
        thinkpad
      ];
    })
  ];
in
builtins.foldl' (acc: secret: acc // secret) { } secrets
