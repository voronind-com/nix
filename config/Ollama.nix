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
  config = lib.mkIf cfg.enable {
    # Specify default model.
    environment.variables.OLLAMA_MODEL = cfg.primaryModel;

    systemd.services = {
      # Enable Ollama server.
      ollama = {
        description = "Ollama LLM server";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
        };
        script = ''
          HOME=/root ${lib.getExe pkgsUnstable.ollama} serve
        '';
      };

      # Download Ollama models.
      ollama-pull = {
        description = "Ollama LLM model";
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
        after = [
          "NetworkManager-wait-online.service"
          "ollama.service"
        ];
        wants = [
          "NetworkManager-wait-online.service"
          "ollama.service"
        ];
        script = ''
          sleep 5
          HOME=/root ${lib.getExe pkgsUnstable.ollama} pull ${lib.concatStringsSep " " cfg.models}
        '';
      };
    };
  };
}
