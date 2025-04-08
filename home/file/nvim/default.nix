{
  config,
  inputs,
  lib,
  pkgs,
  util,
  ...
}:
let
  plugins =
    inputs
    |> lib.filterAttrs (n: v: lib.hasPrefix "nvim-" n)
    |> lib.attrsToList
    |> map (i: "${inputs.${i.name}}");

  # Directories for nvim to use.
  runtimes = plugins ++ [
    "~/.cache/nvim"
    "~/.cache/nvim/treesitter"
  ];

  moduleConfig = util.ls ./module/config;
  modulePlugin = util.ls ./module/plugin;
  moduleLsp = util.ls ./module/lsp;
  moduleKey = util.ls ./module/key;

  # Configuration.
  inherit (config.module.style) color;
  inherit (color) accent selection;
  bg = color.bg.regular;
  fg = color.fg.dark;

  # Plugin paths to install.
  runtimeRc = builtins.foldl' (acc: r: acc + "set runtimepath+=${r}\n") "" runtimes;

  # My configuration files combined into one big file.
  cfgRaw = pkgs.writeText "nvim-rc-raw" (
    util.readFiles (moduleConfig ++ modulePlugin ++ moduleLsp ++ moduleKey)
  );
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
