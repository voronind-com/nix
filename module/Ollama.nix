# https://github.com/ollama/ollama
{
  pkgsStable,
  lib,
  config,
  ...
}:
with lib;
let
  pkgs = pkgsStable;
  cfg = config.module.ollama;
in
{
  options = {
    module.ollama = {
      enable = mkEnableOption "Local LLM server";
      primaryModel = mkOption {
        default = "llama3";
        type = types.str;
      };
      models = mkOption {
        default = [ cfg.primaryModel ];
        type = types.listOf types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    environment = {
      # Specify default model.
      variables.OLLAMA_MODEL = cfg.primaryModel;
    };

    systemd.services = {
      # Enable Ollama server.
      ollama = {
        description = "Ollama LLM server.";
        wantedBy = [ "multi-user.target" ];
        wants = [ "NetworkManager-wait-online.service" ];
        after = [ "NetworkManager-wait-online.service" ];
        serviceConfig.Type = "simple";
        script = ''
          HOME=/root ${getExe pkgs.ollama} serve
        '';
      };

      # Download Ollama models.
      ollamamodel = {
        description = "Ollama LLM model.";
        wantedBy = [ "multi-user.target" ];
        wants = [ "ollama.service" ];
        after = [ "ollama.service" ];
        serviceConfig.Type = "simple";
        script = ''
          sleep 5
          ${getExe pkgs.ollama} pull ${concatStringsSep " " cfg.models}
        '';
      };
    };
  };
}
