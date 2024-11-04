# Collection of common functions.
{ lib }: rec {
	# Remove tabs indentation,
	trimTabs = text: let
		shouldStripTab = lines: builtins.all (line: (line == "") || (lib.strings.hasPrefix "	" line)) lines;
		stripTab       = lines: builtins.map (line: lib.strings.removePrefix "	" line) lines;
		stripTabs      = lines: if (shouldStripTab lines) then (stripTabs (stripTab lines)) else lines;
	in builtins.concatStringsSep "\n" (stripTabs (lib.strings.splitString "\n" text));

	# List all files in a dir.
	ls = path: map (f: "${path}/${f}") (builtins.attrNames (builtins.readDir path));

	# Concat all files by `text` key.
	catText = files: args: builtins.foldl' (acc: mod: acc + (trimTabs (import mod args).text)) "" files;

	# Concat all file paths by `file` key.
	catFile = files: args: builtins.foldl' (acc: mod: acc + (trimTabs (builtins.readFile (import mod args).file))) "" files;

	# Concat all files as a set.
	catSet = files: args: builtins.foldl' (acc: mod: acc // mod) { } (map (file: import file args) files);

	# Systemd service that does not restart with system switch.
	mkStaticSystemdService = params: params // {
		restartIfChanged           = false;
		stopIfChanged              = false;
		unitConfig.X-StopOnRemoval = false;
	};
}
