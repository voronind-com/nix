{ ... }:
{
  text = ''
    export _flatpakcfg_path="''${HOME}/.config/linux/Flatpak.txt"

    # Prune everything unused in docker.
    function prune_docker() {
      docker system prune --volumes --all
    }

    # Prune Nix Store.
    function prune_nix() {
      nix-store --gc
    }

    # Uninstall flatpaks not listed in the config.
    function prune_flatpak() {
      local IFS=$'\n'
      local config=($(cat ''${_flatpakcfg_path} | cut -f2))
      local installed=($(flatpak list --app | cut -f2))

      process() {
        _contains ''${target} ''${config[@]} || flatpak uninstall ''${target}
      }

      _iterate_targets process ''${installed[@]}
    }
  '';
}
