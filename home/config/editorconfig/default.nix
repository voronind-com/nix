{
	pkgs,
	...
}: {
	file = (pkgs.formats.iniWithGlobalSection { }).generate "EditorconfigConfig" {
		globalSection = {
			root = true;
		};
		sections = {
			"*" = {
				charset      = "utf-8";
				end_of_line  = "lf";
				indent_size  = 8;
				indent_style = "tab";
				insert_final_newline     = false;
				trim_trailing_whitespace = true;
			};
			"*.nix" = {
				indent_size = 2;
			};
			"*.{lua,kt,kts,rs,py}" = {
				indent_size = 4;
			};
		};
	};
}
