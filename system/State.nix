{ config, ... }:
{
  # Specify current release version.
  system.stateVersion = config.module.const.stateVersion;
}
