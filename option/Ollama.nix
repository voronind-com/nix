# SRC: https://github.com/ollama/ollama
{ config, lib, ... }:
let
  cfg = config.module.ollama;
  purpose = config.module.purpose;
in
{
  options.module.ollama = {
    enable = lib.mkEnableOption "the local LLM server." // { default = purpose.work && purpose.desktop; };
    models = lib.mkOption {
      default = [ cfg.primaryModel ];
      type = with lib.types; listOf str;
    };
    primaryModel = lib.mkOption {
      default = "llama3.3";
      type = lib.types.str;
    };
  };
}
