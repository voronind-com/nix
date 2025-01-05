{ ... }:
{
  services.changedetection-io = {
    enable = true;
    baseURL = "change.voronind.com";
    behindProxy = true;
    port = 5001;
  };
}
