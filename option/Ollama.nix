# SRC: https://github.com/ollama/ollama
{ config, lib, ... }:
let
  cfg = config.module.ollama;
  purpose = config.module.purpose;
in
{
  options.module.ollama = {
    enable = lib.mkEnableOption "the local LLM server." // {
      default = purpose.work;
    };
    models = lib.mkOption {
      default = [ cfg.primaryModel ];
      type = with lib.types; listOf str;
    };
    # REF: https://ollama.com/library
    primaryModel = lib.mkOption {
      default = "deepseek-r1";
      type = lib.types.str;
    };
  };
}
