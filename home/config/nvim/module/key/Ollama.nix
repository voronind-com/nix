{ ... }:
{
  text = ''
    rekey_normal("<Leader>p", ":<c-u>lua require('ollama').prompt()<cr>")
    rekey_visual("<Leader>p", ":<c-u>lua require('ollama').prompt()<cr>")
  '';
}
