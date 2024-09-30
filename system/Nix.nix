{ ... }: {
	# Allow installation of proprietary software.
	nixpkgs.config.allowUnfree = true;

	nix.settings = {
		# Deduplicate store automatically. Slows down switches a bit, but saves space.
		auto-optimise-store = true;

		# Allow use of flakes.
		experimental-features = [ "nix-command " "flakes" ];

		# When running GC, keep .drv files.
		keep-derivations = true;

		# When running GC, keep build dependencies.
		keep-outputs = true;

		# Run GC automatically when there's a less free space than specified.
		min-free = 1 * 1000 * 1000 * 1000;
	};

	# NOTE: Currently I run GC completely, but this setting (put above near min-free)
	# can stop GC when you hit 101 GB of free space available.
	# max-free = ${toString 101 * 1024 * 1024 * 1024}

	# NOTE: Enable this if you want to run GC on schedule. I instead use `min-free`.
	# nix.gc = {
	# 	automatic  = true;
	# 	dates      = "weekly";
	# 	options    = "--delete-older-than 30d";
	# 	persistent = true;
	# };
}
