{ config, ... }:
let
in
{
  networking.hostId =
    config.networking.hostName |> builtins.hashString "sha1" |> builtins.substring 0 8;
  boot = {
    initrd.supportedFilesystems.zfs = true;
    supportedFilesystems.zfs = true;
    # zfs.enabled = true; # NOTE: Auto-enabled by above variables.
  };
  services.zfs = {
    trim = {
      enable = true;
      interval = "weekly";
    };
    autoScrub = {
      enable = true;
      interval = "quarterly";
      pools = [ ];
    };
    autoSnapshot = {
      enable = true;
      flags = "-k -p --utc";
      frequent = 0;
      hourly = 24;
      daily = 7;
      weekly = 4;
      monthly = 0;
    };

    # TODO: Add to home.
    # autoReplication = {};

    # TODO: Learn & configure ZED.
    # zed = {
    #   enableMail = true;
    #   settings = {
    #
    #   };
    # };
  };
}
