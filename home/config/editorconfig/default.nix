{ pkgs, ... }:
{
  file = (pkgs.formats.iniWithGlobalSection { }).generate "EditorconfigConfig" {
    globalSection.root = true;

    sections = {
      "*" = {
        end_of_line = "lf";
        charset = "utf-8";
        indent_style = "tab";
        indent_size = 2;
        insert_final_newline = "true";
        trim_trailing_whitespace = "true";
      };

      "Makefile" = {
        indent_size = 4;
      };

      "*.nix" = {
        indent_style = "space";
        indent_size = 2;
      };

      "*.{lua,kt,kts,rs,py}" = {
        indent_size = 4;
      };

      "*.{sh,md}" = {
        indent_size = 8;
      };
    };
  };
}
