{ lib, ... }:
{
  "org/gnome/desktop/session" = with lib.gvariant; {
    idle-delay = mkUint32 0;
  };
}
