{ pkgs, ... }:
{
  services.kavita = {
    enable = true;
    tokenKeyFile = pkgs.writeText "KavitaToken" "xY19aQOa939/Ie6GCRGbubVK8zRwrgBY/20AuyMpYshUjwK1Uyl7bw1yknVh6jJIFIfwq2vAjeotOUq7NEsf9Q==";
    settings = {
      # IpAddresses = cfg.address;
      Port = 5000;
    };
  };
}
