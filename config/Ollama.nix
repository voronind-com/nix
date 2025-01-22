{
  config,
  lib,
  pkgsUnstable,
  ...
}:
let
  cfg = config.module.ollama;
in
{
  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      host = "[::1]";
      loadModels = cfg.models;
      package = pkgsUnstable.ollama;
      # acceleration = false;
    };
  };
}
