{ ... }:
{
  text = ''
    export _gdconf_path="''${HOME}/.config/linux/Gnome.dconf"

    # Load Gnome settings.
    function dconf_load() {
      sed -i -e s/voronind/$(whoami)/g ''${_gdconf_path} ; dconf load / < ''${_gdconf_path}
    }

    # Dump Gnome settings into the file.
    # Default name is `gnome.dconf`.
    # Do this before changing settings and after, an then run `diff` to find out what to add to the main `gnome.dconf`.
    # Usage: dconf_save [FILE]
    function dconf_save() {
      local name="''${1}"
      [[ "''${name}" = "" ]] && name="gnome.dconf"
      dconf dump / > "''${name}"
    }
  '';
}
