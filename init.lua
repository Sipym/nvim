-- 绑定<leader>为‘;’
vim.g.mapleader = ';'
require("config.lazy")

-- 设置主题
vim.o.background = "light" -- or "light" for light mode
--vim.g.material_style = "Oceanic"
vim.opt.termguicolors = true

vim.cmd([[colorscheme gruvbox]])


