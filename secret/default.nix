{ config, ... }:
let
  host = config.module.network.host;
in
{
  # Password used for root user.
  # Use `mkpasswd -s`.
  password = {
    dasha = "$y$j9T$WGMPv/bRhGBUidcZLZ7CE/$raZhwFFdI/XvegVZVHLILJLMiBkOxSErc6gao/Cxt33";
    live = "$y$j9T$nPMHO52xsFp6ZShidRwVC1$2w9BWmGsCkopKx3L3QLXOnJNCNwtwTOlQ/BzQJEerp0"; # "live".
    root = "$y$j9T$2QLDojShRRcjNJLy.eEbz1$cPqwveCpWH.Dbizv8ODUdu6M/YlxtVO60dalkjHGa8B";
    voronind = "$y$j9T$Ur/VIyHSkwjntGEa0dHV//$lzgc9Br591nvMwytxDbQOQcPBM2h3SKpT8LH8MdboX4";
  };

  ssh = {
    # Keys that are allowed to connect via SSH.
    trustedKeys = [
      host.phone.key
      (builtins.readFile ./ssh.key)
    ];

    # Keys that are allowd to connect via SSH to nixbuild user for Nix remote builds.
    builderKey = "nixbuilder-1:Skghjixd8lPzNe2ZEgYLM9Pu/wF9wiZtZGsdm3bo9h0=";
    buildKeys = with host; [
      dasha.key
      desktop.key
      max.key
      thinkpad.key
    ];
  };

  crypto = {
    # Git commit signing.
    sign.git = {
      allowed = ./signers.key;
      format = "ssh";
      key = ./ssh.key;
    };

    # List of accepted public keys.
    publicKeys = [
      {
        source = ./gpg.key;
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
