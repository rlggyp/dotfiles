-- options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.updatetime = 200
vim.opt.fileencoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.cursorline = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.swapfile = false

-- global
vim.g.mapleader = " "

-- keymap
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

vim.api.nvim_set_keymap("n", "<C-Up>", ":resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Down>", ":resize +2<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

vim.api.nvim_set_keymap("n", "<C-c>", ":!g++ %:t -o %:r<Enter>", opts)
vim.api.nvim_set_keymap("n", "<C-x>", ":!./%:r<Enter>", opts)

vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

vim.api.nvim_set_keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.api.nvim_set_keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
vim.api.nvim_set_keymap("v", "<A-j>", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("x", "J", ":m '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "K", ":m '<-2<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)
