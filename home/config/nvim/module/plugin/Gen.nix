{ config, ... }:
{
  text = ''
    require("gen").setup {
      model = "${config.setting.ollama.primaryModel}"
    }
  '';
}
