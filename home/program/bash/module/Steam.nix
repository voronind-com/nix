{ ... }:
{
  text = ''
    # Start Steam with Wayland screen share for Link to work.
    function steam_link() {
      steam -pipewire -pipewire-dmabuf
    }
  '';
}
