{ ... }:
{
  text = ''
    function monitor() {
      notify_short
      toggle() {
        local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
        local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .power')

        if ''${state}; then
          swaymsg "output \"''${output}\" power off"
        else
          swaymsg "output \"''${output}\" power on"
        fi

        pkill -RTMIN+4 waybar
      }
      _sway_iterate_sockets toggle
    }

    function monitorreset() {
      swaymsg 'output * power on'
      pkill -RTMIN+4 waybar
    }

    function gaming() {
      notify_short
      toggle() {
        local output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
        local state=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .adaptive_sync_status')

        if [[ "''${state}" = "disabled" ]]; then
          swaymsg "output \"''${output}\" adaptive_sync on"
        else
          swaymsg "output \"''${output}\" adaptive_sync off"
        fi

        pkill -RTMIN+4 waybar
      }
      _sway_iterate_sockets toggle
    }

    function gamingreset() {
      swaymsg 'output * adaptive_sync off'
      pkill -RTMIN+4 waybar
    }

    function dnd() {
      toggle() {
        local state=$(makoctl mode)

        if [[ "''${state}" = "dnd" ]]; then
          makoctl mode -s default
          notify_short
        else
          notify_short
          makoctl mode -s dnd
        fi

        pkill -RTMIN+4 waybar
      }
      _sway_iterate_sockets toggle
    }

    # Reset the state of everything.
    function displayreset() {
      notify_long
      [[ "''$(monitorstate)"   = "Y" ]] && monitorreset
      [[ "''$(gamingstate)"    = "Y" ]] && gamingreset
      [[ "''$(recordingstate)" = "Y" ]] && pkill wf-recorder
      [[ "''$(dndstate)"       = "Y" ]] && dnd
      true
    }

    # Waybar output.
    function displaywidget() {
      local _monitorstate=$(monitorstate)
      local _gamingstate=$(gamingstate)
      local _recordingstate=$(recordingstate)
      local _dndstate=$(dndstate)
      local class=""

      if [[ "''${_monitorstate}" = "Y" ]] || [[ "''${_gamingstate}" = "Y" ]] || [[ "''${_recordingstate}" = "Y" ]] || [[ "''${_dndstate}" = "Y" ]]; then
        class="modified"
      fi

      printf "%s" "{\"text\": \"󰍹\", \"tooltip\": \"󰍶 ''${_dndstate}\\t󰶐 ''${_monitorstate}\\n󰡈 ''${_gamingstate}\\t󰻂 ''${_recordingstate}\", \"class\": \"''${class}\"}\n"
    }

    function monitorstate() {
      local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .power'))

      for state in "''${outputs[@]}"; do
        ''${state} || {
          printf "%s" Y
          return 1
        }
      done

      printf "%s" n
      return 0
    }

    function recordingstate() {
      [[ "$(ps cax | rg wf-recorder)" = "" ]] && printf "%s" n || printf "%s" Y
    }

    function dndstate() {
      [[ "$(makoctl mode)" = "dnd" ]] && printf "%s" Y || printf "%s" n
    }

    function gamingstate() {
      local outputs=($(swaymsg -t get_outputs | jq -r '.[] | .adaptive_sync_status'))

      for state in "''${outputs[@]}"; do
        [[ "''${state}" = "disabled" ]] || {
          printf "%s" Y
          return 1
        }
      done

      printf "%s" n
      return 0
    }
  '';
}
