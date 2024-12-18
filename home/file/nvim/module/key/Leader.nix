{ ... }:
{
  text = ''
    leader = " "

    vim.g.mapleader      = leader
    vim.g.maplocalleader = leader

    -- Disable key press timeout.
    vim.cmd("set notimeout nottimeout")
  '';
}
