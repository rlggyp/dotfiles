local opt = vim.opt -- for conciseness

opt.termguicolors = true
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.showtabline = 2
opt.shiftwidth = 2
opt.updatetime = 200
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus"
opt.smartcase = true
opt.ignorecase = true
opt.cursorline = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.hlsearch = true
opt.showmode = true
opt.swapfile = false
opt.signcolumn = "yes"
opt.splitright = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local statusline = {
  ' %t',
  '%r',
  '%m',
  '%=',
  '%{&filetype}',
  ' %2p%%',
  ' %3l:%-2c '
}

vim.o.statusline = table.concat(statusline, '')

