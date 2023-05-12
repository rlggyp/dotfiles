vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim' 
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
	use 'preservim/nerdtree'
	use 'jistr/vim-nerdtree-tabs'

end)