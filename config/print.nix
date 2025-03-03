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
        ServerName [${config.module.const.home}]
      '';
    };
  };
}
