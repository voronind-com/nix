let
  yubikey = builtins.readFile ./secret/age/yubikey_recepient.key;
  host = (import ./secret { }).network.host;

  mkSecret = name: hosts: {
    "secret/age/${name}.age".publicKeys = [ yubikey ] ++ (map (host: host.key) hosts);
  };

  secrets = with host; [ (mkSecret "telegram_notify" [ home ]) ];
in
builtins.foldl' (acc: secret: acc // secret) { } secrets
