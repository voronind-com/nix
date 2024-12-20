{ lib, ... }:
let
  storage = "/storage/hot/data";

  binds = [
    (mkBind "change" "/var/lib/changedetection-io")
    (mkBind "cups" "/var/lib/cups")
    (mkBind "deluge" "/var/lib/deluge/.config/deluge")
    (mkBind "dkim" "/var/dkim")
    (mkBind "dovecot_index" "/var/lib/dovecot/indices")
    (mkBind "forgejo" "/var/lib/forgejo")
    (mkBind "grocy" "/var/lib/grocy")
    (mkBind "hass" "/var/lib/hass")
    (mkBind "jellyfin" "/var/lib/jellyfin")
    (mkBind "jellyfin_cache" "/var/cache/jellyfin")
    (mkBind "kavita" "/var/lib/kavita")
    (mkBind "letsencrypt" "/etc/letsencrypt")
    (mkBind "murmur" "/var/lib/murmur")
    (mkBind "nextcloud" "/var/lib/nextcloud")
    (mkBind "ovpn" "/var/lib/ovpn")
    (mkBind "paperless" "/var/lib/paperless")
    (mkBind "postgres" "/var/lib/postgresql")
    (mkBind "privatebin" "/var/lib/privatebin")
    (mkBind "rabbitmq" "/var/lib/rabbitmq")
    (mkBind "sieve" "/var/sieve")
    (mkBind "terraria" "/var/lib/terraria")
    (mkBind "uptime_kuma" "/var/lib/uptime-kuma")
    (mkBind "vaultwarden" "/var/lib/vaultwarden")
    (mkBind "vmail" "/var/vmail")
  ];

  mkBind = name: path: {
    ${path} = {
      device = "${storage}/${name}";
      options = [
        "bind"
        "nofail"
        "X-mount.mkdir=1777"
      ];
    };
  };
in
{
  fileSystems = lib.foldl' (acc: bind: acc // bind) { } binds;
}
