vim.g.mapleader = ";"
require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- 让光标保持在上次光标的位置
vim.cmd([[
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- 设置主题
vim.cmd([[colorscheme gruvbox]])
vim.o.background = "light" -- or "light" for light mode
--vim.g.material_style = "Oceanic"
vim.opt.termguicolors = true


