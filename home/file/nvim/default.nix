{
  config,
  inputs,
  pkgs,
  util,
  ...
}:
let
  # Directories for nvim to use.
  runtimes = [
    "~/.cache/nvim"
    "~/.cache/nvim/treesitter"
    "${inputs.nvim-align}"
    "${inputs.nvim-autoclose}"
    "${inputs.nvim-bufferline}"
    "${inputs.nvim-close-buffers}"
    "${inputs.nvim-colorizer}"
    "${inputs.nvim-ctags}"
    "${inputs.nvim-devicons}"
    "${inputs.nvim-dressing}"
    "${inputs.nvim-git-signs}"
    "${inputs.nvim-gruvbox-material}"
    "${inputs.nvim-indentomatic}"
    "${inputs.nvim-lspconfig}"
    "${inputs.nvim-plenary}"
    "${inputs.nvim-telescope}"
    "${inputs.nvim-todo}"
    "${inputs.nvim-treesitter}"
    "${inputs.nvim-tree}"
    "${inputs.nvim-trouble}"
  ];

  # Order of files to load.
  configs = [
    ./module/key/rekey.lua
    ./module/key/leader.lua
    ./module/config/autoread.lua
    ./module/config/etc.lua
    ./module/config/search.lua
    ./module/config/tab.lua
    ./module/config/highlight.lua
    ./module/plugin/filetree.lua
    ./module/plugin/gruvbox.lua
    ./module/plugin/bufferline.lua
    ./module/plugin/autoclose.lua
    ./module/plugin/gitsigns.lua
    ./module/plugin/trouble.lua
    ./module/plugin/closebuffers.lua
    ./module/plugin/telescope.lua
    ./module/plugin/todo.lua
    ./module/plugin/indent.lua
    ./module/plugin/align.lua
    ./module/plugin/treesitter.lua
    ./module/plugin/fold.lua
    ./module/plugin/colorizer.lua
    ./module/plugin/dressing.lua
    ./module/plugin/lsp/go.lua
    ./module/plugin/lsp/haskell.lua
    ./module/plugin/lsp/lua.lua
    ./module/plugin/lsp/nix.lua
    ./module/plugin/lsp/rust.lua
    ./module/plugin/lsp/tex.lua
    ./module/plugin/lsp/ctags.lua
    ./module/key/autocomplete.lua
    ./module/key/buffer.lua
    ./module/key/cmd.lua
    ./module/key/colorscheme.lua
    ./module/key/filetree.lua
    ./module/key/gitsigns.lua
    ./module/key/navigation.lua
    ./module/key/prompt.lua
    ./module/key/save.lua
    ./module/key/sort.lua
    ./module/key/tab-width.lua
    ./module/key/telescope.lua
    ./module/key/terminal.lua
    ./module/key/trouble.lua
  ];

  # Configuration.
  accent = config.module.style.color.accent;
  bg = config.module.style.color.bg.regular;
  fg = config.module.style.color.fg.dark;
  selection = config.module.style.color.selection;

  # Plugin paths to install.
  runtimeRc = builtins.foldl' (acc: r: acc + "set runtimepath+=${r}\n") "" runtimes;

  # My configuration files combined into one big file.
  cfgRaw = pkgs.writeText "nvim-rc-raw" (util.readFiles configs);
  cfg = pkgs.replaceVars cfgRaw {
    inherit
      accent
      bg
      fg
      selection
      ;
  };

  # Tell Neovim to load this file.
  configRc = "lua dofile(\"${cfg}\")";

  init = pkgs.writeText "nvim-init" (runtimeRc + configRc);
in
{
  inherit init;
}
