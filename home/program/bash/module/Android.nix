{ ... }:
{
  text = ''
    # Start an Android emulator.
    # Default name is `main`.
    # Usage: emulator [NAME]
    function emulator() {
      local name="$1"

      [[ "$name" = "" ]] && name="main"

      steam-run ~/.android/sdk/emulator/emulator -avd "$name" &> /dev/null & disown
    }

    function _android_emulators() {
      _autocomplete_first $(ls --classify ~/.android/avd/ | grep \/$ | sed -e "s/.avd\/$//")
    }

    complete -F _android_emulators emulator
  '';
}
