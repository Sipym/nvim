vim.g.mapleader = ";"

-- 定义一个全局变量，用于“在需要提供绝对路径时使用”
local uname = vim.loop.os_uname()
if uname and uname.sysname then
	if uname.sysname == "Darwin" then
		-- macOS
		vim.g.homedir = "/Users/awjl"
	elseif uname.sysname == "Linux" then
		-- Linux
		vim.g.homedir = "/home/awjl"
	else
		-- Unsupported OS
		print("Unsupported OS: " .. uname.sysname)
	end
else
	print("Failed to determine OS.")
end
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
