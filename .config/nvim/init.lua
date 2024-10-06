require 'core.keymaps'
require 'core.options'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	require 'plugins.colorscheme',
	require 'plugins.bufferline',
	require 'plugins.treesitter',
	-- require 'plugins.lualine',
	require 'plugins.lazygit',
	-- require 'plugins.alpha',
	require 'plugins.misc',
	require 'plugins.autocompletion',
	require 'plugins.lsp',
	require 'plugins.telescope',
	-- require 'plugins.telescope-file-browser',
	-- require 'plugins.oil-nvim',
	require 'plugins.nvim-tree',
	require 'plugins.gitsigns',
	-- require 'plugins.indent-blankline',
	require 'plugins.comment',
	require 'plugins.silicon',
	require 'plugins.nvim-tmux-navigator',
	-- require 'plugins.image-preview',
})
