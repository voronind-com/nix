{
  container,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.container.module.search;
in
{
  options = {
    container.module.search = {
      enable = mkEnableOption "Search frontend.";
      address = mkOption {
        default = "10.1.0.26";
        type = types.str;
      };
      port = mkOption {
        default = 8080;
        type = types.int;
      };
      domain = mkOption {
        default = "search.${config.container.domain}";
        type = types.str;
      };
      storage = mkOption {
        default = "${config.container.storage}/search";
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    containers.search = container.mkContainer cfg {
      config =
        { ... }:
        container.mkContainerConfig cfg {
          services.searx = {
            enable = true;
            package = pkgs.searxng;
            # REF: https://github.com/searxng/searxng/blob/master/searx/settings.yml
            settings = {
              general = {
                debug = false;
                instance_name = "SearX";
                enable_metrics = false;
              };
              server = {
                bind_address = cfg.address;
                port = cfg.port;
                secret_key = "searxxx";
                limiter = false;
                public_instance = false;
                image_proxy = false;
                method = "GET";
              };
              search = {
                safe_search = 0;
                autocomplete = "";
                autocomplete_min = 4;
                default_lang = "auto";
              };
              ui = {
                infinite_scroll = false;
                default_theme = "simple";
                center_alignment = false;
                default_locale = "";
                simple_style = "dark";
                hotkeys = "vim";
              };
              outgoing = {
                request_timeout = 3.0;
                max_request_timeout = 10.0;
                pool_connections = 100;
                pool_maxsize = 20;
                enable_http2 = true;
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
                "Tracker URL remover"
                "Hostnames plugin"
              ];
              hostnames = {
                replace = with config.container.module; {
                  "(.*\.)?youtube\.com$" = yt.domain;
                  "(.*\.)?youtu\.be$" = yt.domain;
                };
                remove = [
                  "(.*\.)?dzen\.ru?$"
                  "(.*\.)?facebook.com$"
                  "(.*\.)?gosuslugi\.ru?$"
                  "(.*\.)?quora\.com?$"
                  "(.*\.)?rutube\.ru?$"
                  "(.*\.)?vk\.com?$"
                ];
                low_priority = [
                  "(.*\.)?google(\..*)?$"
                  "(.*\.)?microsoft\.com?$"
                ];
                high_priority = [ "(.*\.)?wikipedia.org$" ];
              };
              categories_as_tabs = {
                general = { };
                images = { };
                videos = { };
                news = { };
                map = { };
                it = { };
                files = { };
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
        };
    };
  };
}
