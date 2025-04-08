# IRC web client.
# SRC: https://github.com/thelounge/thelounge
{
  services.thelounge = {
    enable = true;
    extraConfig = {
      reverseProxy = true;
      # defaults = {
      #   name = "voronind";
      #   host = "localhost";
      #   port = 6697;
      # };
    };
  };
}
