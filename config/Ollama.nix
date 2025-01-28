{
  config,
  inputs,
  lib,
  pkgsUnstable,
  ...
}:
let
  cfg = config.module.ollama;
in
{
  disabledModules = [ "services/misc/ollama.nix" ];
  imports = [ "${inputs.nixpkgsMaster}/nixos/modules/services/misc/ollama.nix" ];

  config = lib.mkIf cfg.enable {
    environment.variables.OLLAMA_MODEL = cfg.primaryModel;
    services.ollama = {
      enable = true;
      host = "[::1]";
      loadModels = cfg.models;
      package = pkgsUnstable.ollama;
      # acceleration = false;
    };
  };
}
