{ pkgs, __findFile, ... }: {
	fonts.packages = with pkgs; [
		# Use Apple fonts for system and text.
		(pkgs.callPackage <package/applefont> {})

		# Use Nerd version of Terminus for monospaced fonts.
		(nerdfonts.override { fonts = [ "Terminus" ]; })

		# I don't use FA, but add it for compatibility.
		font-awesome

		# Minecraft font.
		minecraftia
	];
}
