# SRC: https://github.com/ollama/ollama
{
  pkgsUnstable,
  lib,
  config,
  ...
}:
let
  cfg = config.module.ollama;
in
{
  options = {
    module.ollama = {
      enable = lib.mkEnableOption "Local LLM server";
      primaryModel = lib.mkOption {
        default = "llama3.2";
        type = lib.types.str;
      };
      models = lib.mkOption {
        default = [ cfg.primaryModel ];
        type = with lib.types; listOf str;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Specify default model.
    environment.variables.OLLAMA_MODEL = cfg.primaryModel;

    systemd.services = {
      # Enable Ollama server.
      ollama = {
        description = "Ollama LLM server.";
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
        script = ''
          HOME=/root ${lib.getExe pkgsUnstable.ollama} serve
        '';
      };

      # Download Ollama models.
      ollama-pull = {
        description = "Ollama LLM model.";
        wantedBy = [ "multi-user.target" ];
        wants = [
          "NetworkManager-wait-online.service"
          "ollama.service"
        ];
        after = [
          "NetworkManager-wait-online.service"
          "ollama.service"
        ];
        serviceConfig.Type = "simple";
        script = ''
          sleep 5
          ${lib.getExe pkgsUnstable.ollama} pull ${lib.concatStringsSep " " cfg.models}
        '';
      };
    };
  };
}
