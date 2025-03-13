{
  config,
  lib,
  secret,
  ...
}:
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
        ServerName [${secret.network.host.home.ip}]
      '';
    };
  };
}
