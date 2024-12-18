{ ... }:
{
  # Don't suspend on lid closed.
  services.logind.lidSwitch = "ignore";
}
