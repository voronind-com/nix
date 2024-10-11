{ ... }:
{
  text = ''
    # Attach/create container box in current directory with specified name.
    # By default uses current dir name.
    # Usage: ca [NAME]
    function ca() {
      local name="''${1}"

      # Set default name.
      # [[ "''${name}" = "" ]] && name="main"
      [[ "''${name}" = "" ]] && name=$(parse_alnum "''${PWD##*/}")

      # Append box prefix.
      name="box-''${name}"

      # Create container.
      docker run \
        --privileged \
        -d -it \
        -h "''${HOSTNAME}''${name#box}" --name "''${name}" \
        --workdir /data \
        -e XDG_RUNTIME_DIR=/tmp \
        -e WAYLAND_DISPLAY=''${WAYLAND_DISPLAY} \
        -v ''${XDG_RUNTIME_DIR}/''${WAYLAND_DISPLAY}:/tmp/''${WAYLAND_DISPLAY} \
        -v ''${PWD}:/data \
        -v ''${HOME}:/root \
        debian:latest bash -c bash &> /dev/null

      # Attempt to start container.
      docker start "''${name}" &> /dev/null

      # Attach to running container.
      docker attach "''${name}"
    }

    # Remove container box with specified name.
    # By default uses current dir name.
    # Usage: ck [NAME]
    function ck() {
      local name="''${1}"

      # Set default name.
      [[ "''${name}" = "" ]] && name=$(parse_alnum "''${PWD##*/}")

      # Append box prefix.
      name="box-''${name}"

      # Kill container.
      docker kill "''${name}" &> /dev/null
      docker rm   "''${name}" &> /dev/null
    }

    # Remove all container boxes.
    function cka() {
      local IFS=$'\n'
      local boxes=$(_get_boxes)

      for box in ''${boxes[@]}; do
        ck "''${box}"
      done
    }

    # List all container boxes.
    function cl() {
      _get_boxes
    }

    # Print all boxes.
    function _get_boxes() {
      local IFS=$'\n'
      local boxes=$(docker ps -a | grep "box-" | sed -e "s/.*box-//")

      [[ "''${boxes[@]}" != "" ]] && echo "''${boxes[@]}" || true
    }

    # Autocomplete with boxes.
    function _comp_get_boxes() {
      local IFS=$'\n'
      _autocomplete_first $(_get_boxes)
    }

    complete -F _comp_get_boxes ca ck
  '';
}
