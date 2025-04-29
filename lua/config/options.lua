-- Options Configure

vim.cmd.syntax("on")         -- 启用语法高亮
vim.g.mapleader        = ";" -- 使<leader>键为';'

vim.opt.encoding       = "utf-8"
vim.opt.fileencoding   = "utf-8"

vim.opt.bufhidden      = "hide"
vim.opt.relativenumber = true
vim.opt.autochdir = true
vim.opt.swapfile       = false
vim.opt.number         = true
vim.opt.cursorline     = true -- 突出显示当前行
vim.opt.showcmd        = true
vim.opt.laststatus     = 3    -- 每个窗口都显示状态栏
vim.opt.autoindent     = true
vim.opt.smartindent    = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.softtabstop    = 2
vim.opt.expandtab      = true
vim.opt.backup         = false
vim.opt.backupcopy     = "yes"
vim.opt.backupskip     = { "/tmp/*", "/private/tmp/*" }
vim.opt.smarttab       = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.breakindent    = true -- 行太长时，自动换行时保持缩进
vim.opt.wrap           = true
vim.opt.splitkeep      = "cursor"
vim.opt.clipboard      = 'unnamedplus' -- 共享剪切板
vim.opt.mouse          = ''            -- 不使用鼠标
vim.opt.incsearch      = true          -- 匹配模式中，随着字符的输入,实时显示匹配的pattern
vim.opt.hidden         = true          -- 当关闭缓冲区的时候，不会删除它,而是隐藏他
vim.opt.signcolumn     = 'yes'         -- 在左边预留一个空间，避免布局出现偏移
vim.opt.conceallevel   = 1

-- File types
vim.filetype.add({
  extension = {
    -- kjmdx = "mdx",
  },
})
