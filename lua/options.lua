vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.laststatus = 3
opt.showmode = false
opt.showtabline = 2

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 400

opt.completeopt = { "menu", "menuone", "noselect" }

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

local osc52 = require("vim.ui.clipboard.osc52")
vim.g.clipboard = {
  name = "OSC 52",
  copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
  paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
}
opt.clipboard = "unnamedplus"
