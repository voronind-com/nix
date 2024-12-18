{ ... }:
let
  focus = true;
in
{
  text = ''
    -- Toggle diagnostics window.
    rekey_normal("<Leader>2", "<cmd>Trouble diagnostics toggle focus=${toString focus}<cr>")

    -- Toggle To-do window.
    rekey_normal("<Leader>3", "<cmd>Trouble todo toggle focus=${toString focus}<cr>")
  '';
}
