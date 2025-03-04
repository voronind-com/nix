{ lib, ... }:
let
  mkTypeOption = default: type: lib.mkOption { inherit default type; };
  mkStrOption = default: mkTypeOption default lib.types.str;
in
{
  options.module.network = {
    ula = mkStrOption "fd09:8d46:b26::/48";
    host = {
      dasha.ip = mkStrOption "fd09:8d46:b26:0:2ef0:5dff:fe3b:778";
      desktop.ip = mkStrOption "fd09:8d46:b26:0:dabb:c1ff:fecc:da30";
      home.ip = mkStrOption "fd09:8d46:b26:0:180c:8bff:fe13:2910";
      max.ip = mkStrOption "fd09:8d46:b26:0:c2a5:e8ff:feb5:d916";
      phone.ip = mkStrOption "fd09:8d46:b26:0:f774:b83e:61f0:6ebe";
      printer.ip = mkStrOption "fd09:8d46:b26:0:9e1c:37ff:fe62:3fd5";
      router.ip = mkStrOption "fd09:8d46:b26:0:9e9d:7eff:fe8e:3dc7";
    };
  };
}
