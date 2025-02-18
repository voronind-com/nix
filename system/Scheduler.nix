{ config, ... }:
let
  # purpose = config.module.purpose;

  scheduler = "scx_bpfland";
  # ISSUE: Not working?
  # isServer = with purpose; server || router;
  # extraArgs = if isServer then [ "-c 0" ] else [ ]; # REF: https://github.com/sched-ext/scx/pull/1094
  extraArgs = [ ];
in
{
  services.scx = {
    enable = true;
    inherit extraArgs scheduler;
  };
}
