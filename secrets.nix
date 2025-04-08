let
  yubikey = builtins.readFile ./secret/age/yubikey-recepient.key;
  inherit ((import ./secret { }).network) host;

  mkSecret =
    {
      names,
      hosts,
      extra ? { },
    }:
    builtins.foldl' (
      acc: name:
      acc
      // {
        "secret/age/${name}.age" = {
          publicKeys = [ yubikey ] ++ (map (host: host.key) hosts);
        } // extra;
      }
    ) { } names;

  secrets = with host; [
    (mkSecret {
      names = [ "wifi" ];
      hosts = [
        max
        thinkpad
      ];
    })
    (mkSecret {
      names = [
        "vpn/fsight/ca"
        "vpn/fsight/cert"
        "vpn/fsight/key"
        "vpn/fsight/pw"
      ];
      hosts = [
        desktop
        max
      ];
    })
    (mkSecret {
      names = [
        "vpn/home/ca"
        "vpn/home/cert"
        "vpn/home/key"
      ];
      hosts = [
        max
        thinkpad
      ];
    })
    (mkSecret {
      names = [ "noreply-password" ];
      hosts = [
        dasha
        desktop
        max
        thinkpad
      ];
    })
  ];
in
builtins.foldl' (acc: secret: acc // secret) { } secrets
