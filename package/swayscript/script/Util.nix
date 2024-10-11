{ ... }:
{
  text = ''
    # Find currently active SWAYSOCK paths.
    function _sway_find_sockets() {
      ls /run/user/''${UID}/sway-ipc.''${UID}.*.sock
    }

    function _sway_iterate_sockets() {
      local IFS=$'\n'
      for socket in $(_sway_find_sockets); do
        SWAYSOCK="''${socket}" ''${1}
      done
    }
  '';
}
