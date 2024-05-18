return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 50,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	config = true,
	-- 	opts = {},
  --  	config = function()
  --  	  vim.cmd([[colorscheme gruvbox]])
  --  	end,
	-- }
}
