call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'preservim/nerdtree' " nerdtree file explorer
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim' 
  Plug 'neovim/nvim-lspconfig' 
  Plug 'airblade/vim-gitgutter'
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
set nowrap
set cursorcolumn
set encoding=utf-8
set clipboard=unnamedplus
set foldmethod=marker
set syntax=markdown
set updatetime=100
set t_Co=256
"set undodir=~/.config/nvim/undodir
"set undofile
colorscheme tokyonight-night
let g:tokyonight_enable_italic = 1
let g:lightline = {'colorscheme': 'tokyonight'}
let g:fzf_action = { 'enter' : 'tab split'}
let g:gitgutter_highlight_lines = 1
highlight SignColumn gui=Bold
nnoremap <M-Tab> :NERDTreeTabsToggle<CR>
silent! nmap <M-F> :Files!<CR>
silent! nmap <M-f> :Rg! 
silent! nmap <M-1> :tabprevious<CR>
silent! nmap <M-2> :tabnext<CR>
silent! nmap <M-q> :tabclose<CR>
silent! nmap <M-n> :tabnew<CR>
nnoremap <C-c> :!g++ %:t -o %:r<Enter>
nnoremap <C-x> :!./%:r<Enter>
"nnoremap <M-c> :!clear && arduino-cli compile -p /dev/ttyUSB0 --fqbn arduino:avr:nano:cpu=atmega328old 
"nnoremap <M-v> :!clear && arduino-cli upload -p /dev/ttyUSB0 --fqbn arduino:avr:nano:cpu=atmega328old 
"inoremap { {}<Esc>ha
"inoremap ( ()<Esc>ha
"inoremap [ []<Esc>ha
"inoremap " ""<Esc>ha
"inoremap ' ''<Esc>ha
"inoremap ` ``<Esc>ha
" -- language server protocol
"
lua << EOF
  require'lspconfig'.clangd.setup{}
EOF
