-- Turn off paste mode when leaving insert
-- vim.api.nvim_create_autocmd("InsertLeave", {
--   pattern = "*",
--   command = "set nopaste",
-- })


-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "json", "jsonc", "markdown" },
--   callback = function()
--     vim.opt.conceallevel = 0
--   end,
-- })


--===============vtags和verilog编写相关配置==============
--实现了每次进入.v文件时自动执行source ...指令
--每次退出.v文件时更新vtags
vim.cmd([[
    augroup AutoSourcevtags_vim_api
      "autocmd!
      "" verilog使用缩进的方式折叠
      autocmd BufEnter *.v set foldmethod=indent
      autocmd BufEnter *.v set shiftwidth=2
      au BufRead,BufNewFile *.v set filetype=verilog
      au BufRead,BufNewFile *.vh set filetype=verilog
      autocmd BufEnter *.v source  ~/Software/vtags-3.11/vtags_vim_api.vim
      "这是用于实现保存，更新，我暂时关闭
      "autocmd BufUnload *.v :!python3 /home/awjl/Software/vtags-3.11/vtags.py
    augroup END


    "shortcut key	function
    "mt	            print module trace from top to current cursor module.
    "gi	            进入子模块
    "gu	            回到上层模块
    "gs	            trace source
    "gd	            trace destination
    "gf	            go forward
    "gb	            jjjroll back
    "<Space><Left>	trace source
    "<Space><Right>	trace destination
    "<Space><Down>	roll back
    "<Space><Up>	go forward
    "<Space> + v	显示侧边栏
    "<Space> + c	add checkpoint
    "<Space> + b	add basemodule
    "<Space> + d	delete
    "<Space> + h	hold cur window
    "<Space>	    quick access
    "<Space> + s	保存快照

  " augroup AutoSetMarkdownIndent
  "   "autocmd!
  "   autocmd BufEnter *.md :set shiftwidth=3
  "   "为markdown的片段兼容tex片段支持
  "   autocmd BufEnter *.md :UltiSnipsAddFiletypes markdown.tex
  " 
  "   "autocmd BufEnter *.md :set complete+=k
  "   "" 为markdown添加补全字典
  "   "autocmd BufEnter *.md :set dictionary+=/home/awjl/1.txt
  " augroup END
]])
