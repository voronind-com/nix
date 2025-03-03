{ pkgs, ... }:
{
  file = (pkgs.formats.iniWithGlobalSection { }).generate "editorconfig-config" {
    globalSection = {
      root = true;
    };
    sections = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        indent_size = 8;
        indent_style = "tab";
        insert_final_newline = false;
        trim_trailing_whitespace = true;
      };
      "*.nix" = {
        indent_style = "space";
        indent_size = 2;
      };
      "*.{lua,kt,kts,rs,py}" = {
        indent_size = 4;
      };
      "*.md" = {
        trim_trailing_whitespace = false;
      };
    };
  };
}
