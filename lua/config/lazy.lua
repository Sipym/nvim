-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.g.mapleader = ";" -- 使<leader>键为';'
vim.g.maplocalleader = "\\"

-- 通过plugins来安装插件,使代码更加的简洁
require("lazy").setup("plugins")

vim.cmd([[
    "=========================================================
    "===================== vim自身配置 =======================
    "=========================================================

    "使得vim首先在当前目录寻找tags文件，如果没有则往上递归寻找
    set tags=tags;
    set autochdir
    set background=dark
    syntax enable  "开启语法高亮
    syntax on
    "共享剪切板,相互之间都共享
    set clipboard+=unnamedplus
    "不用鼠标
    set mouse=""
    set showmatch		" Show matching brackets.
    set wildmenu	    "补全命令
    set ignorecase		" Do case insensitive matching
    set smartcase		" Do smart case matching
    set incsearch		" Incremental search
    set hidden		" Hide buffers when they are abandoned
    setlocal noswapfile " 不要生成swap文件
    set bufhidden=hide " 当buffer被丢弃的时候隐藏它
    set rnu         "显示相对行数
    set nu
    set cursorline " 突出显示当前行
    set ruler " 打开状态栏标尺
    filetype indent on	" 自适应不同语言的智能缩进
    set expandtab	" 将制表符扩展为空格
    set tabstop=2	" 设置编辑时制表符占用空格数
    set shiftwidth=2	" 设置格式化时制表符占用空格数
    set softtabstop=2	" 让 vim 把连续数量的空格视为一个制表符
    set nobackup " 覆盖文件时不备份
    set autochdir " 自动切换当前目录为当前文件所在的目录
    set backupcopy=yes " 设置备份时的行为为覆盖
    set hlsearch " 搜索时高亮显示被找到的文本
    set noerrorbells " 关闭错误信息响铃
    set novisualbell " 关闭使用可视响铃代替呼叫
    set t_vb= " 置空错误铃声的终端代码
    set matchtime=2 " 短暂跳转到匹配括号的时间
    set magic " 改变搜索模式所用的特殊字符，具体看手册
    set smartindent " 开启新行时使用智能自动缩进
    set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
    set cmdheight=1 " 设定命令行的行数为 1

    """""" 折叠相关
    set foldenable " 开始折叠
    set foldmethod=indent  " 设置语法折叠
    set foldcolumn=0 " 设置折叠区域的宽度
    setlocal foldlevel=9 " 设置折叠层数为 1
    "折叠  za,打开/关闭当前折叠；zM，关闭所有折叠；zR,打开所有折叠

    "让光标保持在上次光标的位置
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    "=========================================================
    "====================== nvim的基本映射 ===================
    "=========================================================
    noremap J 5j
    noremap K 5k
    noremap H 5h
    noremap L 5l

    "保存内容
    noremap <leader>s :w<CR>
    let mapleader = ';'
    map s 'nop'
    " map e 'nop'
    "打开终端，并取消行号显示
    nmap <leader>t  :ter <CR>:set nonu<CR>

    "======================= 窗口管理 =========================

    "hjkl分屏命令，分别是向右，左，上，下分屏
    map sh  :set nosplitright<CR>:vsplit<CR>
    map sl  :set splitright<CR>:vsplit<CR>
    map sj  :set splitbelow<CR>:split<CR>
    map sk  :set nosplitbelow<CR>:split<CR>

    "用来选分屏wasd
    map <LEADER>d <C-w>l
    map <LEADER>a <C-w>h
    map <LEADER>w <C-w>k
    map <LEADER>s <C-w>j

    "交换窗口顺序 大写R或X则是相反的交换顺序
    "向右交换窗口  <C-w-r>
    "向下交换窗口  <C-w-x>

    "用来调节屏幕大小
    map <up> :res +5<CR>
    map <down> :res -5<CR>
    map <left> :vertical resize-5<CR>
    map <right> :vertical resize+5<CR>

    "分别是：上下变左右，左右变上下
    map sv <C-w>t<C-w>H
    map ss <C-w>t<C-w>K

    "vim标签页
    map te :tabe<CR>
    map th :-tabnext<CR>
    map tl :+tabnext<CR>

    "打开vim时执行消除高亮命令
    noremap S :source $MYVIMRC <CR>
    exec ':noh'

    "========================================================
    "========================vim自动命令====================
    "========================================================

    "===============vtags和verilog编写相关配置==============
    "实现了每次进入.v文件时自动执行source ...指令
    "每次退出.v文件时更新vtags
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


    "==============markdown相关==============
    "每次进入markdown文件时，将tab缩进设置为2格
    "每次离开markdown文件时，将tab缩进设置回来

    augroup AutoSetMarkdownIndent
      "autocmd!
      autocmd BufEnter *.md :set shiftwidth=3
      "为markdown的片段兼容tex片段支持
      autocmd BufEnter *.md :UltiSnipsAddFiletypes markdown.tex

      "autocmd BufEnter *.md :set complete+=k
      "" 为markdown添加补全字典
      "autocmd BufEnter *.md :set dictionary+=/home/awjl/1.txt
    augroup END


]])
