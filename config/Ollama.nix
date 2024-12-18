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
  config = lib.mkIf cfg.enable {
    # Specify default model.
    # environment.variables.OLLAMA_MODEL = cfg.primaryModel;
    #
    # systemd.services = {
    #   # Enable Ollama server.
    #   ollama = {
    #     description = "Ollama LLM server";
    #     serviceConfig = {
    #       Type = "simple";
    #     };
    #     wantedBy = [
    #       "multi-user.target"
    #     ];
    #     script = ''
    #       HOME=/root ${lib.getExe pkgsUnstable.ollama} serve
    #     '';
    #   };
    #
    #   # Download Ollama models.
    #   ollama-pull = {
    #     description = "Ollama LLM model";
    #     after = [
    #       "NetworkManager-wait-online.service"
    #       "ollama.service"
    #     ];
    #     wantedBy = [
    #       "multi-user.target"
    #     ];
    #     wants = [
    #       "NetworkManager-wait-online.service"
    #       "ollama.service"
    #     ];
    #     serviceConfig = {
    #       Type = "simple";
    #     };
    #     script = ''
    #       sleep 5
    #       ${lib.getExe pkgsUnstable.ollama} pull ${lib.concatStringsSep " " cfg.models}
    #     '';
    #   };
    # };
  };
}
