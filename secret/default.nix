{ ... }:
{
  # Password used for root user.
  # Use `mkpasswd -s`.
  password = {
    dasha = "$y$j9T$WGMPv/bRhGBUidcZLZ7CE/$raZhwFFdI/XvegVZVHLILJLMiBkOxSErc6gao/Cxt33";
    live = "$y$j9T$nPMHO52xsFp6ZShidRwVC1$2w9BWmGsCkopKx3L3QLXOnJNCNwtwTOlQ/BzQJEerp0"; # "live".
    root = "$y$j9T$oqCB16i5E2t1t/HAWaFd5.$tTaHtAcifXaDVpTcRv.yH2/eWKxKE9xM8KcqXHfHrD7";
    voronind = "$y$j9T$e/mHHkIIAXc0HuQdR3PE6/$Jbh6gJgd0M/s6zCqnsB284a9tlRdLclZSaaSKurIJjB";
  };

  ssh = {
    # Keys that are allowed to connect via SSH.
    trustedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTI4IUkHH0JSzWDKOAMbzEDbyBXOrmTHRy+tpqJ8twx nix-on-droid@nothing2"
      (builtins.readFile ./Ssh.key)
    ];

    # Keys that are allowd to connect via SSH to nixbuild user for Nix remote builds.
    builderKey = "nixbuilder-1:Skghjixd8lPzNe2ZEgYLM9Pu/wF9wiZtZGsdm3bo9h0=";
    buildKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENY0NICXvlTOSZEwivRHEGO1PUzgsmoHwf+zqS7WsGV root@max"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuuw5ek5wGB9KdBhCTxjV+CBpPU6RIOynHkFYC4dau3 root@dasha"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHBAqquW9mzssSY22XBXvtAsa19WtIgM5xQ+mXZX6W9 root@thinkbook"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgiYKFkMfiGOZCZIk+O7LtaoF6A3cHEFCqaPwXOM4rR root@thinkpad"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIf192IxsksM6u8UY+eqpHopebgV+NNq2G03ssdXIgz root@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSWdbkYsRiDlKu8iT/k+JN4KY08iX9qh4VyqxlpEZcE root@home"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOaoyC/grc3SfO5blKWRUwW+dLlcfyvuvWjymprfIeqN root@msi"
    ];
  };

  crypto = {
    # Git commit signing.
    sign.git = {
      allowed = ./Signers.key;
      format = "ssh";
      key = ./Ssh.key;
    };

    # List of accepted public keys.
    publicKeys = [
      {
        source = ./Gpg.key;
        trust = 5;
      }
    ];
  };

  tg = {
    # Ob fs lo l.
    bt =
      "ht"
      + "tp"
      + "s://ap"
      + "i.tel"
      + "egra"
      + "m.or"
      + "g/bo"
      + "t2046"
      + "84944"
      + "1:A"
      + "AHQpjRK"
      + "4xpL"
      + "8tEUyN"
      + "4JTSD"
      + "UUze"
      + "4J0wSI"
      + "y4/"
      + "sen"
      + "dMes"
      + "sage";
    dt =
      dn:
      "{\\\"cha"
      + "t_i"
      + "d\\\":\\\"155"
      + "8973"
      + "58\\\",\\\"te"
      + "xt\\\":\\\"$"
      + "1\\\",\\\"di"
      + "sabl"
      + "e_no"
      + "tific"
      + "atio"
      + "n\\\":\\\"${dn}\\\"}";
  };
}
