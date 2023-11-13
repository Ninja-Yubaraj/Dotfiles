-- Editor Settings --
-- Set colorscheme --
vim.o.termguicolors = true
vim.cmd [[colorscheme catppuccin]]

-- Love Relative Line Numbers
vim.opt.relativenumber = true

-- 4 Space Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Helps with Search Highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Less Disorienting Scroll
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Love Fast Update time
vim.opt.updatetime = 50

-- I don't wanna go beyond 80
vim.opt.colorcolumn = "80"
