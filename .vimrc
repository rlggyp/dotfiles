call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'mattn/emmet-vim'
call plug#end()
syntax on
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','
set exrc
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set rnu nu
set noshowmode
set nohlsearch
set noerrorbells
set ignorecase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
colorscheme gruvbox
set background=dark
set clipboard=unnamed
nnoremap <C-c> :!clear && g++ %:t -o %:r<Enter>
nnoremap <C-x> :!clear && ./%:r<Enter>
