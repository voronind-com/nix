{ config, lib, ... }:
let
  cfg = config.module.print;
in
{
  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      # NOTE: Cups server - Share/Allow remote printing on main page.
      clientConf = ''
        DigestOptions DenyMD5
        ServerName [fd09:8d46:b26:0:8079:82ff:fe1a:916a]
      '';
    };
  };
}
