{ ... }:
{
  text = ''
    # Toggle vpn.
    function vpn() {
      notify_short
      if [[ "$(_vpn)" = "on" ]]; then
        nmcli connection down Vpn
      else
        nmcli connection up Vpn
      fi
    }

    function _vpn() {
      local state=$(nmcli connection show Vpn | rg -i state.*activated)
      [ "''${state}" != "" ] && printf on || printf off
    }
  '';
}
