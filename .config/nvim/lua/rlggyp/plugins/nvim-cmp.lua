return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    local lspkind = require("lspkind")

    local check_backspace = function()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
    end

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup {
		  snippet = {
		    expand = function(args)
		      luasnip.lsp_expand(args.body) -- For `luasnip` users.
		    end,
		  },
		  mapping = {
		    -- ["<C-k>"] = cmp.mapping.select_prev_item(),
				-- ["<C-j>"] = cmp.mapping.select_next_item(),
		    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		    ["<C-e>"] = cmp.mapping {
		      i = cmp.mapping.abort(),
		      c = cmp.mapping.close(),
		    },
		    -- Accept currently selected item. If none selected, `select` first item.
		    -- Set `select` to `false` to only confirm explicitly selected items.
		    ["<CR>"] = cmp.mapping.confirm { select = true },
		    -- ["<Tab>"] = cmp.mapping(function(fallback)
		    ["<C-j>"] = cmp.mapping(function(fallback)
		      if cmp.visible() then
		        cmp.select_next_item()
		      elseif luasnip.expandable() then
		        luasnip.expand()
		      elseif luasnip.expand_or_jumpable() then
		        luasnip.expand_or_jump()
		      elseif check_backspace() then
		        fallback()
		      else
		        fallback()
		      end
		    end, {
		      "i",
		      "s",
		    }),
		    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
		    ["<C-k>"] = cmp.mapping(function(fallback)
		      if cmp.visible() then
		        cmp.select_prev_item()
		      elseif luasnip.jumpable(-1) then
		        luasnip.jump(-1)
		      else
		        fallback()
		      end
		    end, {
		      "i",
		      "s",
		    }),
		  },
		  formatting = {
		    fields = { "abbr", "menu" },
		    format = function(entry, vim_item)
		      vim_item.kind = string.format('%s', vim_item.kind)
		      vim_item.menu = ({
		        luasnip = "[Snippet]",
		        buffer = "[Buffer]",
		        path = "[Path]",
		      })[entry.source.name]
		      return vim_item
		    end,
		  },
		  sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
		  },
		  confirm_opts = {
		    behavior = cmp.ConfirmBehavior.Replace,
		    select = false,
		  },
		  window = {
		    documentation = cmp.config.window.bordered(),
		  },
		  experimental = {
		    ghost_text = false,
		    native_menu = false,
		  },
		}
  end,
}
