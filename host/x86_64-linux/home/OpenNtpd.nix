{ ... }: {
  services.openntpd = {
    enable = true;
    extraConfig = ''
      listen on 0.0.0.0
      listen on ::
    '';
  };
}
