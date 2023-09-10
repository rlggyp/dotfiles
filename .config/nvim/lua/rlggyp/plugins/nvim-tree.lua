return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    
    local nvimtree = require("nvim-tree")
   -- change color for arrows in tree to light blue
  	vim.cmd([[ highlight NvimTreeIndentMarker guifg=#A9B1D6 ]])
  	
  	-- configure nvim-tree
  	nvimtree.setup({
  	  view = {
  	    width = 35,
  	    relativenumber = true,
  	  },
  	  -- change folder arrow icons
  	  renderer = {
  	    indent_markers = {
  	      enable = true
  	    },
				icons = {
          web_devicons = {
            file = {
              enable = false,
              color = false,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
          glyphs = {
            git = {
              unstaged = "M",
              staged = "S",
              unmerged = "",
              renamed = "R",
              untracked = "U",
              deleted = "D",
              ignored = "I",
            },
          },
        },
  	  },
  	  -- disable window_picker for
  	  -- explorer to work well with
  	  -- window splits
  	  actions = {
  	    open_file = {
  	      window_picker = {
  	        enable = false,
  	      },
  	    },
  	  },
  	  filters = {
  	    custom = { ".DS_Store" },
  	  },
  	  git = {
  	    ignore = true,
  	  },
  	})
  	
  	-- set keymaps
  	local keymap = vim.keymap

		keymap.set("n", "<A-Tab>", "<cmd>NvimTreeToggle<CR>", opts)
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", opts)
		keymap.set("n", "<A-r>", "<cmd>NvimTreeRefresh<CR>", opts)
  end,
}
