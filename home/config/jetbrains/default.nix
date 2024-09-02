{ util, ... }: {
	ideavimrc = util.trimTabs ''
		set scrolloff=4
		set incsearch
		set hlsearch
		set clipboard=unnamedplus
		set relativenumber
		set number

		Plug 'tpope/vim-commentary'
		Plug 'machakann/vim-highlightedyank'
	'';
}
