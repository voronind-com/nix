_: rec {
  network = {
    ula = "fd09:8d46:b26::/48";
    host = {
      dasha = {
        ip = "fd09:8d46:b26:0:2ef0:5dff:fe3b:778";
        key = builtins.readFile ./ssh/dasha.key;
      };
      desktop = {
        ip = "fd09:8d46:b26:0:dabb:c1ff:fecc:da30";
        key = builtins.readFile ./ssh/desktop.key;
      };
      home = {
        ip = "fd09:8d46:b26:0:180c:8bff:fe13:2910";
        key = builtins.readFile ./ssh/home.key;
      };
      max = {
        ip = "fd09:8d46:b26:0:c2a5:e8ff:feb5:d916";
        key = builtins.readFile ./ssh/max.key;
      };
      phone = {
        ip = "fd09:8d46:b26:0:f774:b83e:61f0:6ebe";
        key = builtins.readFile ./ssh/phone.key;
      };
      printer = {
        ip = "fd09:8d46:b26:0:9e1c:37ff:fe62:3fd5";
      };
      router = {
        ip = "fd09:8d46:b26:0:9e9d:7eff:fe8e:3dc7";
      };
      thinkpad = {
        ip = "fd09:8d46:b26:0:1685:7fff:feeb:6c25";
        key = builtins.readFile ./ssh/thinkpad.key;
      };
    };
  };

  # Password used for root user.
  # Use `mkpasswd -s`.
  password = {
    dasha = "$y$j9T$WGMPv/bRhGBUidcZLZ7CE/$raZhwFFdI/XvegVZVHLILJLMiBkOxSErc6gao/Cxt33";
    larisa = "$y$j9T$374cEcaxC8DAfFtR28tJ..$wiVq6dVHrfdkxhIXXeJvpEpfhW5G11EqDt4rZMfe.Z9";
    live = "$y$j9T$nPMHO52xsFp6ZShidRwVC1$2w9BWmGsCkopKx3L3QLXOnJNCNwtwTOlQ/BzQJEerp0"; # "live".
    root = "$y$j9T$2QLDojShRRcjNJLy.eEbz1$cPqwveCpWH.Dbizv8ODUdu6M/YlxtVO60dalkjHGa8B";
    voronind = "$y$j9T$Ur/VIyHSkwjntGEa0dHV//$lzgc9Br591nvMwytxDbQOQcPBM2h3SKpT8LH8MdboX4";
  };

  ssh = {
    # Keys that are allowed to connect via SSH.
    trustedKeys = [
      network.host.phone.key
      (builtins.readFile ./ssh/yubikey.key)
    ];

    # Keys that are allowd to connect via SSH to nixbuild user for Nix remote builds.
    builderKey = "nixbuilder-1:Skghjixd8lPzNe2ZEgYLM9Pu/wF9wiZtZGsdm3bo9h0=";
    buildKeys = with network.host; [
      dasha.key
      desktop.key
      max.key
      thinkpad.key
    ];
  };

  crypto = {
    # Git commit signing.
    sign.git = {
      allowed = ./git/signers.key;
      format = "ssh";
      key = ./ssh/yubikey.key;
    };

    # List of accepted public keys.
    publicKeys = [
      {
        source = ./gpg/yubikey.key;
        trust = 5;
      }
    ];
  };
}
