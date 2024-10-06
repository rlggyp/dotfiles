return {
  'stevearc/oil.nvim',
  opts = {},
  config = function()
    require("oil").setup({
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<A-e>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<A-c>"] = "actions.close",
        ["<A-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        natural_order = true,
        case_insensitive = false,
        sort = {
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      float = {
        padding = 5,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        preview_split = "right",
        override = function(conf)
          return conf
        end,
      },
      preview = {
        max_width = 0.80,
        min_width = { 40, 0.2 },
        max_height = 0.9,
        min_height = { 5, 0.1 },
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        update_on_cursor_moved = true,
      },
      progress = {
        max_width = 0.20,
        min_width = { 40, 0.20 },
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
    })
    vim.keymap.set('n', '-', '<CMD>Oil<CR>')
  end
}
