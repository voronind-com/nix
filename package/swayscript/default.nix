{ pkgs, util, ... }@args:
pkgs.writeShellScriptBin "swayscript" (util.catText (util.ls ./script) args + "\${@}")
