{ lib, ... }:
let
  mkTypeOption = default: type: lib.mkOption { inherit default type; };
  mkStrOption = default: mkTypeOption default lib.types.str;
in
{
  options.module.network = {
    ula = mkStrOption "fd09:8d46:b26::/48";
    host = {
      dasha = {
        ip = mkStrOption "fd09:8d46:b26:0:2ef0:5dff:fe3b:778";
        key = mkStrOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuuw5ek5wGB9KdBhCTxjV+CBpPU6RIOynHkFYC4dau3 root@dasha";
      };
      desktop = {
        ip = mkStrOption "fd09:8d46:b26:0:dabb:c1ff:fecc:da30";
        key = mkStrOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILwQVB+KGyTPi3NX2y6ahiM33y0ispmKbfbQgewnyvCq root@desktop";
      };
      home = {
        ip = mkStrOption "fd09:8d46:b26:0:180c:8bff:fe13:2910";
        key = mkStrOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSWdbkYsRiDlKu8iT/k+JN4KY08iX9qh4VyqxlpEZcE root@home";
      };
      max = {
        ip = mkStrOption "fd09:8d46:b26:0:c2a5:e8ff:feb5:d916";
        key = mkStrOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIENY0NICXvlTOSZEwivRHEGO1PUzgsmoHwf+zqS7WsGV root@max";
      };
      phone = {
        ip = mkStrOption "fd09:8d46:b26:0:f774:b83e:61f0:6ebe";
        key = mkStrOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTI4IUkHH0JSzWDKOAMbzEDbyBXOrmTHRy+tpqJ8twx nix-on-droid@phone";
      };
      printer = {
        ip = mkStrOption "fd09:8d46:b26:0:9e1c:37ff:fe62:3fd5";
      };
      router = {
        ip = mkStrOption "fd09:8d46:b26:0:9e9d:7eff:fe8e:3dc7";
      };
      thinkpad = {
        ip = mkStrOption "fd09:8d46:b26:0:1685:7fff:feeb:6c25";
        key = mkStrOption "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgiYKFkMfiGOZCZIk+O7LtaoF6A3cHEFCqaPwXOM4rR root@thinkpad";
      };
    };
  };
}
