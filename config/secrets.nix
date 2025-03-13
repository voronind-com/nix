{ __findFile, config, ... }:
let
  cfg = config.module.secrets;
  dir = <secret/age>;
in
{
  age.secrets =
    cfg
    |> map (file: {
      name = file;
      value = {
        file = "${dir}/${file}.age";
      };
    })
    |> builtins.listToAttrs;
}
