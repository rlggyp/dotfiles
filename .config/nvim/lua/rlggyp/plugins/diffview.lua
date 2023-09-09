return {
	"sindrets/diffview.nvim",

	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<A-d>", ":DiffviewOpen<CR>", opts)
		keymap.set("n", "<A-c>", ":DiffviewClose<CR>", opts)
	end
}
