{ __findFile, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Terminus" ]; })
    (pkgs.callPackage <package/applefont> { })
    font-awesome
    minecraftia
  ];
}
