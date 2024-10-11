{ ... }:
{
  text = ''
    # Add executable flag to file.
    # Usage: x <FILES>
    function x() {
      chmod +x -- "''${@}"
    }
  '';
}
