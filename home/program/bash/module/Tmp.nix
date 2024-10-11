{ ... }:
{
  text = ''
    # CD into host's primary tmp dir.
    function tmp() {
      local host="''${HOSTNAME}"
      local tmp_path

      case "''${host}" in
        "desktop"|"home")
          tmp_path="/storage/hot/tmp"
          ;;
        *)
          tmp_path="''${HOME}/tmp"
          ;;
      esac

      cd "''${tmp_path}"
    }
  '';
}
