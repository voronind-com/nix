{ lib, ... }:
{
  systemd.services.tandoor-recipes.serviceConfig.DynamicUser = lib.mkForce false;
  users = {
    users.tandoor_recipes = {
      group = "tandoor_recipes";
      home = "/var/lib/tandoor_recipes";
      isSystemUser = true;
    };
    groups.tandoor_recipes = {};
  };
  services.tandoor-recipes = {
    enable = true;
    address = "[::1]";
    port = 33122;
    extraConfig = {
      GUNICORN_MEDIA = 1;
    };
  };
}
