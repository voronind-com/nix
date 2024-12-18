{ ... }:
{
  ideavimrc = ''
    " Plugins.
    Plug 'tpope/vim-commentary'
    Plug 'machakann/vim-highlightedyank'
    " Plug 'junegunn/vim-easy-align'

    " General config.
    set scrolloff=4
    set incsearch
    set hlsearch
    set clipboard=unnamedplus
    set relativenumber
    set number

    " Space as a leader.
    nnoremap <SPACE> <Nop>
    let mapleader=" "

    " Align. ISSUE: Broken.
    " vmap <Leader>a <Plug>(EasyAlign)

    " Sort.
    vmap <Leader>A :sort<cr>
  '';
}
