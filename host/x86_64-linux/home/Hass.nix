{ ... }:
{
  # Allow Hass to talk to Zigbee dongle.
  users.users.hass.extraGroups = [
    "dialout"
    "tty"
  ];

  services.home-assistant = {
    # NOTE: Missing: hacs. Inside hacs: `card-mod`, `Clock Weather Card`, `WallPanel` and `Yandex.Station`.
    enable = true;
    # NOTE: Using imperative config because of secrets.
    config = null;
    extraComponents = [
      "caldav"
      "met"
      "sun"
      "systemmonitor"
      "zha"
    ];
    extraPackages =
      python3Packages: with python3Packages; [
        aiodhcpwatcher
        aiodiscover
        aiogithubapi
        arrow
        async-upnp-client
        av
        go2rtc-client
        gtts
        ha-ffmpeg
        hassil
        home-assistant-intents
        mutagen
        numpy
        pymicro-vad
        pynacl
        pyspeex-noise
        python-telegram-bot
        pyturbojpeg
        zeroconf
      ];
    # lovelaceConfig = {
    #   title = "Home IoT control center.";
    # };
  };
}
