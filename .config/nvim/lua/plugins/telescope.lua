return {
 'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 
	 'nvim-lua/plenary.nvim' 
  },

	config = function()
		require('telescope').setup({
			defaults = {
				border = {
					prompt = { 1, 1, 1, 1 },
					results = { 1, 1, 1, 1 },
					preview = { 1, 1, 1, 1 },
				},
				borderchars = {
					prompt = { " ", " ", "─", "│", "│", " ", "─", "└" },
					results = { "─", " ", " ", "│", "┌", "─", " ", "│" },
					preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
				}
			}
		})

  	local keymap = vim.keymap
		local builtin = require('telescope.builtin')

		keymap.set("n", "<leader>ff", builtin.find_files, {})
		keymap.set('n', '<leader>fg', builtin.live_grep, {})
		keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, {})
		keymap.set('n', '<leader>fs', builtin.buffers, {})
		keymap.set('n', '<leader>gs', builtin.git_status, {})
	end
}

