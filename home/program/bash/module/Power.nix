{ ... }:
{
  text = ''
    # Suspend system.
    function slp() {
      systemctl suspend -i
    }

    # Poweroff.
    function bye() {
      systemctl poweroff -i
    }
  '';
}
