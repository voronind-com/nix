{ config, ... }:
{
  text = ''
    require("ollama").setup {
      model = "${config.setting.ollama.primaryModel}",
      url   = "http://127.0.0.1:11434",
      -- View the actual default prompts in ./lua/ollama/prompts.lua
      prompts = {
        -- Sample_Prompt = {
        --   prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
        --   input_label = "> ",
        --   model = "mistral",
        --   action = "display",
        -- }
      }
    }
  '';
}
