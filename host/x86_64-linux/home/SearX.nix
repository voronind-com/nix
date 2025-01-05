{ config, pkgs, ... }:
{
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    # REF: https://github.com/searxng/searxng/blob/master/searx/settings.yml
    settings = {
      general = {
        debug = false;
        enable_metrics = false;
        instance_name = "SearX";
      };
      server = {
        bind_address = "::1";
        image_proxy = false;
        limiter = false;
        method = "GET";
        port = 34972;
        public_instance = false;
        secret_key = "searxxx";
      };
      search = {
        autocomplete = "";
        autocomplete_min = 4;
        default_lang = "auto";
        safe_search = 0;
      };
      ui = {
        center_alignment = false;
        default_locale = "";
        default_theme = "simple";
        hotkeys = "vim";
        infinite_scroll = false;
        simple_style = "dark";
      };
      outgoing = {
        enable_http2 = true;
        max_request_timeout = 10.0;
        pool_connections = 100;
        pool_maxsize = 20;
        request_timeout = 3.0;
        # proxies = {
        #   "all://" = with config.container.module; [
        #     # "socks5:${frkn.address}:${frkn.port}"
        #     "socks5:${frkn.address}:1081"
        #     # "socks5:${frkn.address}:9150"
        #   ];
        # };
        # using_tor_proxy = true;
        # extra_proxy_timeout = 10;
      };
      # plugins = [ ];
      enabled_plugins = [
        "Basic Calculator"
        "Hostnames plugin"
        "Tracker URL remover"
      ];
      hostnames = {
        replace = {
          "(.*\.)?youtu\.be$" = "yt.voronind.com";
          "(.*\.)?youtube\.com$" = "yt.voronind.com";
        };
        remove = [
          "(.*\.)?dzen\.ru$"
          "(.*\.)?facebook.com$"
          "(.*\.)?gosuslugi\.ru$"
          "(.*\.)?quora\.com$"
          "(.*\.)?rutube\.ru$"
          "(.*\.)?vk\.com$"
        ];
        low_priority = [
          "(.*\.)?google(\..*)?$"
          "(.*\.)?microsoft\.com$"
        ];
        high_priority = [
          "(.*\.)?4pda.to$"
          "(.*\.)?github.com$"
          "(.*\.)?wikipedia.org$"
        ];
      };
      categories_as_tabs = {
        files = { };
        general = { };
        images = { };
        it = { };
        map = { };
        news = { };
        videos = { };
      };
      engines =
        let
          mkEnable = name: {
            inherit name;
            disabled = false;
          };
          mkDisable = name: {
            inherit name;
            disabled = true;
          };
        in
        [
          (mkEnable "bing")
          (mkDisable "qwant")
        ];
    };
  };
}
