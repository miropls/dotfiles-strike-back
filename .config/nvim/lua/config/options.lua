-- lua/config/options.lua
vim.g.mapleader = " "

local o = vim.opt
o.showtabline = 1
o.guicursor = ""
o.nu = true
o.relativenumber = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = false
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.showmode = false
o.hlsearch = false
o.incsearch = true
o.termguicolors = true
o.scrolloff = 8
o.signcolumn = "yes"
o.isfname:append("@-@")
o.updatetime = 50
o.winborder = "rounded"
