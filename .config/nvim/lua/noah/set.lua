vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.background = "dark"

vim.opt.errorbells = false

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.clipboard = "unnamedplus"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.shortmess:append("c")
vim.opt.colorcolumn = "120"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.list = true
vim.opt.listchars = {
  eol = ' ',
  trail = '·',
  extends = ' ',
  precedes = ' ',
  tab = '  ',
}

vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrows = 1
vim.g.NERDTreeWinSize = 30
