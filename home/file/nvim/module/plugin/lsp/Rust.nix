{ ... }:
{
  text = ''
    local lspconfig = require("lspconfig")

    lspconfig.rust_analyzer.setup {
      settings = {
        ["rust-analyzer"] = {
          rustfmt = {
            extraArgs = {
              "--config",
              "hard_tabs=true",
            }
          }
        },
      },
    }

    vim.g.rust_recommended_style = false
  '';
}
