-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("v", "<leader>jk", "<ESC>", { desc = "Exit visual mode with leader jk" })

keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
keymap.set("x", "J", ":m '>+1<CR>gv-gv", opts)
keymap.set("x", "K", ":m '<-2<CR>gv-gv", opts)
keymap.set("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

keymap.set("n", "<S-Tab>", ":bprev<CR>", opts)
keymap.set("n", "<Tab>", ":bnext<CR>", opts)
keymap.set("n", "<A-n>", ":enew<CR>", opts)
keymap.set("n", "<A-q>", ":bdelete %<CR>", opts)

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("v", "<A-=>", "g<C-a>", { desc = "Increment number" }) -- increment
keymap.set("v", "<A-->", "g<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<A-v>", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<A-h>", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<A-s>", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<A-w>", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
