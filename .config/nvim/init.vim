call plug#begin()
  Plug 'arcticicestudio/nord-vim' 
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'preservim/nerdtree' " nerdtree file explorer
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy find 
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim' 
call plug#end()
filetype on
filetype plugin on
filetype indent on
syntax on
set nocompatible
set termguicolors
set expandtab
set shiftwidth=2
set softtabstop=2
set shiftround
set smartindent
set wildmenu
set cindent
set signcolumn=no
set exrc
set nu rnu
set noshowmode
set nohlsearch
set noerrorbells
set ignorecase
set smartcase
set noswapfile
set nobackup
set mouse=a
set cursorline
set cursorcolumn
set encoding=utf-8
set clipboard=unnamedplus
set foldmethod=marker
set syntax=markdown
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
let g:lightline = {'colorscheme': 'tokyonight'}
nnoremap <M-Tab> :NERDTreeTabsToggle<CR>
silent! nmap <M-F> :Files<CR>
silent! nmap <M-f> :Rg!
silent! nmap <M-1> :tabprevious<CR>
silent! nmap <M-2> :tabnext<CR>
silent! nmap <M-q> :tabclose<CR>
silent! nmap <M-n> :tabnew<CR>
"nnoremap <C-c> :!g++ %:t -o %:r<Enter>
"nnoremap <C-x> :!./%:r<Enter>
"nnoremap <M-c> :!clear && arduino-cli compile -p /dev/ttyUSB0 --fqbn arduino:avr:nano:cpu=atmega328old 
"nnoremap <M-v> :!clear && arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:nano:cpu=atmega328old 
"inoremap { {}<Esc>ha
"inoremap ( ()<Esc>ha
"inoremap [ []<Esc>ha
"inoremap " ""<Esc>ha
"inoremap ' ''<Esc>ha
"inoremap ` ``<Esc>ha
