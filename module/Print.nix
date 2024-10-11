{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.print;
in
{
  options = {
    module.print.enable = mkEnableOption "Add support for printers.";
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      clientConf = ''
        DigestOptions DenyMD5
        ServerName 10.0.0.1
      '';
    };
  };
}
