{ ... }: {
  services.tandoor-recipes = {
    enable = true;
    address = "[::1]";
    port = 33122;
  };
}
