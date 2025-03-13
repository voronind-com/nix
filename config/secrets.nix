{ __findFile, config, lib, ... }:
let
  cfg = config.module.secrets;
  dir = <secret/age>;
in
{
  age = {
    identityPaths = lib.mkForce [ "/root/.ssh/id_ed25519" ];

    secrets =
      cfg
      |> map (file: {
        name = file;
        value = {
          file = "${dir}/${file}.age";
        };
      })
      |> builtins.listToAttrs;
  };
}
