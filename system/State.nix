{ config, ... }:
{
  # Specify current release version.
  system.stateVersion = config.const.stateVersion;
}
