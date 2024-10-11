{ ... }:
{
  text = ''
    local lspconfig = require('lspconfig')
    local config = {
      filetypes = {
        "bib",
        "gitcommit",
        "markdown",
        "org",
        "pandoc",
        "plaintex",
        "rnoweb",
        "rst",
        "tex",
        "text",
      },
      settings = {
        ["ltex"] = {
          language = "auto"
        }
      }
    }

    lspconfig.ltex.setup(config)

    -- Use TeX LSP for spellcheck.
    vim.api.nvim_create_user_command("SCOn", function (args)
      lspconfig.ltex.setup(config)
    end, { desc = "Enable spellcheck." })

    vim.api.nvim_create_user_command("SCOff", function (args)
      lspconfig.ltex.setup { filetypes = {} }
    end, { desc = "Disable spellcheck." })

    vim.api.nvim_create_user_command("SCLangRU", function (args)
      config.settings['ltex'].language = "ru-RU"
      lspconfig.ltex.setup(config)
    end, { desc = "Set spellcheck to Russian." })

    vim.api.nvim_create_user_command("SCLangEN", function (args)
      config.settings['ltex'].language = "en-US"
      lspconfig.ltex.setup(config)
    end, { desc = "Set spellcheck to English." })

    vim.api.nvim_create_user_command("SCLangAuto", function (args)
      config.settings['ltex'].language = "auto"
      lspconfig.ltex.setup(config)
    end, { desc = "Set spellcheck to Auto." })

    vim.api.nvim_create_user_command("SCForce", function (args)
      vim.cmd("setfiletype text")
      vim.cmd("SCOn")
    end, { desc = "Set buffer type to text." })

    vim.api.nvim_create_user_command("SCReset", function (args)
      vim.cmd("filetype detect")
      vim.cmd("SCLangAuto")
    end, { desc = "Set buffer type to auto." })

    vim.api.nvim_create_user_command("SCInfo", function (args)
      vim.cmd("LspInfo")
    end, { desc = "Show info about spellcheck." })
  '';
}
