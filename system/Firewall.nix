{ lib, ... }:
{
  networking.firewall = {
    enable = true;

    # NOTE: Configure manually with `extraCommands`.
    allowedTCPPortRanges = lib.mkForce [ ];
    allowedTCPPorts = lib.mkForce [ ];
    allowedUDPPortRanges = lib.mkForce [ ];
    allowedUDPPorts = lib.mkForce [ ];

    allowPing = true;
    rejectPackets = false; # Drop.

    logRefusedConnections = false;
    logRefusedPackets = false;
    logRefusedUnicastsOnly = true;
    logReversePathDrops = false;
  };
}
