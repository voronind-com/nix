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
    "${inputs.nvimAlign}"
    "${inputs.nvimAutoclose}"
    "${inputs.nvimBufferline}"
    "${inputs.nvimCloseBuffers}"
    "${inputs.nvimColorizer}"
    "${inputs.nvimDevicons}"
    "${inputs.nvimDressing}"
    "${inputs.nvimGen}"
    "${inputs.nvimGitsigns}"
    "${inputs.nvimGruvboxMaterial}"
    "${inputs.nvimIndentoMatic}"
    "${inputs.nvimLspconfig}"
    "${inputs.nvimPlenary}"
    "${inputs.nvimTelescope}"
    "${inputs.nvimTodo}"
    "${inputs.nvimTreesitter}"
    "${inputs.nvimTree}"
    "${inputs.nvimTrouble}"
  ];

  # Order of files to load.
  configs = [
    ./module/key/Rekey.lua
    ./module/key/Leader.lua
    ./module/config/Autoread.lua
    ./module/config/Etc.lua
    ./module/config/Search.lua
    ./module/config/Tab.lua
    ./module/config/Highlight.lua
    ./module/plugin/Filetree.lua
    ./module/plugin/Gruvbox.lua
    ./module/plugin/Bufferline.lua
    ./module/plugin/Autoclose.lua
    ./module/plugin/Gitsigns.lua
    ./module/plugin/Trouble.lua
    ./module/plugin/Closebuffers.lua
    ./module/plugin/Telescope.lua
    ./module/plugin/Todo.lua
    ./module/plugin/Indent.lua
    ./module/plugin/Align.lua
    ./module/plugin/Treesitter.lua
    ./module/plugin/Fold.lua
    ./module/plugin/Gen.lua
    ./module/plugin/Colorizer.lua
    ./module/plugin/Dressing.lua
    ./module/plugin/lsp/Go.lua
    ./module/plugin/lsp/Haskell.lua
    ./module/plugin/lsp/Lua.lua
    ./module/plugin/lsp/Nix.lua
    ./module/plugin/lsp/Rust.lua
    ./module/plugin/lsp/Tex.lua
    ./module/key/Autocomplete.lua
    ./module/key/Buffer.lua
    ./module/key/Cmd.lua
    ./module/key/Colorscheme.lua
    ./module/key/Filetree.lua
    ./module/key/Gitsigns.lua
    ./module/key/Navigation.lua
    ./module/key/Prompt.lua
    ./module/key/Save.lua
    ./module/key/Sort.lua
    ./module/key/TabWidth.lua
    ./module/key/Telescope.lua
    ./module/key/Terminal.lua
    ./module/key/Trouble.lua
  ];

  # Configuration.
  accent = config.module.style.color.accent;
  bg = config.module.style.color.bg.regular;
  fg = config.module.style.color.fg.dark;
  ollamaModel = config.module.ollama.primaryModel;
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
      ollamaModel
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
