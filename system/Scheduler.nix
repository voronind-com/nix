{ config, ... }:
let
  purpose = config.module.purpose;

  scheduler = "scx_bpfland";
  isServer = with purpose; server || router;
  extraArgs = if isServer then [ "-c 0" ] else [ ]; # REF: https://github.com/sched-ext/scx/pull/1094
in
{
  services.scx = {
    enable = true;
    inherit extraArgs scheduler;
  };
}
