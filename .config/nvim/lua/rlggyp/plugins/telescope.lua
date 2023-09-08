return {
 'nvim-telescope/telescope.nvim', tag = '0.1.2',
  dependencies = { 
	 'nvim-lua/plenary.nvim' 
  },

	config = function()
		require('telescope.builtin')

  	local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<A-F>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
		keymap.set("n", "<A-f>", "<cmd>Telescope live_grep<cr>", opts)
	end
}
