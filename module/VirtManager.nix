{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.module.virtmanager;
in
{
  options = {
    module.virtmanager.enable = mkEnableOption "VM support.";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # HACK: Fixes bug: https://www.reddit.com/r/NixOS/comments/1afbjiu/i_get_a_nonetype_error_when_trying_to_launch_a_vm/
    # May also need to run: `gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"`
    environment.systemPackages = with pkgs; [
      # glib
      adwaita-icon-theme # default gnome cursors,
    ];
  };
}
