{
  config,
  lib,
  pkgs,
  secret,
  util,
  ...
}:
let
  accent = "${config.module.style.color.accentR};${config.module.style.color.accentG};${config.module.style.color.accentB}";
  negative = "${config.module.style.color.negativeR};${config.module.style.color.negativeG};${config.module.style.color.negativeB}";
  neutral = "${config.module.style.color.neutralR};${config.module.style.color.neutralG};${config.module.style.color.neutralB}";
  positive = "${config.module.style.color.positiveR};${config.module.style.color.positiveG};${config.module.style.color.positiveB}";

  tgbot = secret.tg.bt;
  tgdata = secret.tg.dt "false";
  tgdatasilent = secret.tg.dt "true";

  modulesRaw = pkgs.writeText "bash-user-modules-raw" (util.readFiles (util.ls ./module));
  modulesFile = pkgs.replaceVars modulesRaw {
    inherit
      accent
      negative
      neutral
      positive
      tgbot
      tgdata
      tgdatasilent
      ;
  };
in
{
  inherit modulesFile;

  bashrc =
    (builtins.readFile modulesFile)
    + ''
      # Find all functions.
      function find_function() {
        /usr/bin/env cat ${modulesFile} | /usr/bin/env grep "^function.*()" | /usr/bin/env sed -e "s/^function //" -e "s/().*//"
      }

      # Export all functions.
      export -f $(find_function | tr '\n' ' ')
      export -f find_function
    ''
    + lib.optionalString config.module.sway.enable ''
      # Autostart Sway.
      if [[ -z $DISPLAY ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
        exec sway
      fi
    '';

  # bash_profile = ''
  #   # Home manager.
  #   [ -e ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh

  #   # Bashrc.
  #   [ -f ~/.bashrc ] && source ~/.bashrc

  #   # Profile.
  #   [ -f ~/.profile ] && source ~/.profile
  # '';

  # profile = ''
  #   # Load HM vars.
  #   [ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # '';
}
