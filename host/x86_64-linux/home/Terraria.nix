{ pkgs, ... }:
{
  # Vanilla.
  # NOTE: tmux -S /var/lib/terraria/terraria.sock attach-session -t 0
  # environment.systemPackages = with pkgs; [ tmux ];
  #
  # services.terraria = {
  #   enable = true;
  #   autoCreatedWorldSize = "large";
  #   messageOfTheDay = "<3";
  #   maxPlayers = 4;
  #   noUPnP = false;
  #   openFirewall = false;
  #   password = "mishadima143";
  #   port = 22777;
  #   secure = false;
  #   worldPath = "/var/lib/terraria/.local/share/Terraria/Worlds/World.wld";
  # };

  # Modded.
  # NOTE: docker exec tmodloader inject "say Hello World!"
  virtualisation.oci-containers.containers.terraria = {
    image = "jacobsmile/tmodloader1.4:latest";
    volumes = [ "/storage/hot/data/terraria_calamity:/data" ];
    ports = [ "0.0.0.0:22777:7777" ];
    environment = {
      TMOD_SHUTDOWN_MESSAGE = "Goodbye! <3";
      TMOD_AUTOSAVE_INTERVAL = "5";
      # TMOD_AUTODOWNLOAD = "3015412343,2824688072,2824688266,2785100219,3222493606"; # NOTE: Comment after loading once.
      TMOD_ENABLEDMODS = "3015412343,2824688072,2824688266,2785100219,3222493606";
      TMOD_MOTD = "<3";
      TMOD_PASS = "mishadima143";
      TMOD_MAXPLAYERS = "2";
      TMOD_WORLDNAME = "CWorld";
      TMOD_WORLDSIZE = "3";
      # TMOD_WORLDSEED = "";
      TMOD_DIFFICULTY = "1";
      TMOD_SECURE = "0";
    };
  };
}
