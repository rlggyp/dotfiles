return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
		require('telescope').setup({
		  vim.keymap.set("n", "<A-e>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)
    })
  end
}
