"保证一个兼容性（maybe）
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
"vim自身配置
set background=dark
syntax enable  "开启语法高亮
syntax on
set showmatch		" Show matching brackets.
set wildmenu   "补全命令
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hidden		" Hide buffers when they are abandoned
setlocal noswapfile " 不要生成swap文件
set bufhidden=hide " 当buffer被丢弃的时候隐藏它
set number " 显示行号
set cursorline " 突出显示当前行
set ruler " 打开状态栏标尺
set shiftwidth=2 " 设定 << 和 >> 命令移动时的宽度为 2
set softtabstop=2 " 使得按退格键时可以一次删掉 2 个空格
set tabstop=2 " 设定 tab 长度为 2
set nobackup " 覆盖文件时不备份
set autochdir " 自动切换当前目录为当前文件所在的目录
set backupcopy=yes " 设置备份时的行为为覆盖
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
set matchtime=2 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%) " 设置在状态行显示的信息
set foldenable " 开始折叠
set foldmethod=syntax " 设置语法折叠
set foldcolumn=0 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为 1
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 用空格键来开关折叠
"让光标保持在上次光标的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"-----修改vim按键设置----------"
noremap J 5j
noremap K 5k
noremap <leader>s :w<CR> 
let mapleader = ';'
map s 'nop'
map e 'nop'

"hjkl分屏命令，分别是向右，左，上，下分屏
map sl  :vsplit<CR>:set nosplitright<CR>
map sh  :vsplit<CR>:set splitright<CR>
map sk  :split<CR>:set splitbelow<CR>
map sj  :split<CR>:set nosplitbelow<CR>

"用来选分屏wasd
map <LEADER>d <C-w>l
map <LEADER>a <C-w>h
map <LEADER>w <C-w>k
map <LEADER>s <C-w>j

"用来调节屏幕大小
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"分别是：上下变左右，左右变上下
map sv <C-w>t<C-w>H
map ss <C-w>t<C-w>K 

"标签页
map te :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>

"打开vim时执行消除高亮命令
noremap S :source $MYVIMRC <CR>
exec ':noh'

"vim-plug管理器
call plug#begin('~/.vim/plugged')
Plug 'francoiscabrol/ranger.vim'
Plug 'vim-airline/vim-airline'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
"Plug ''
call plug#end()

"---------------------------------------------------------
"<在每次启动vim时，检查vim-plug是否被安装>
"---------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif 

"---------------------------------------------------------
"<关于youcompleteme的一些配置>
"---------------------------------------------------------
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
"看文档可以
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
"设置错误显示符号和警告显示符号
let g:ycm_error_symbol = 'X'
let g:ycm_warning_symbol = 'W'
"使得ycm可以补全函数 参考：https://zhuanlan.zhihu.com/p/33046090
let g:ycm_semantic_triggers =  {
				\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
"用来分别打开搜索工作目录或者文件目录，可以用ctrl+c关闭
map <leader>e <Plug>(YCMFindSymbolInWorkspace)
map <leader>r <Plug>(YCMFindSymbolInDocument)
"fi:跳到include包含的那个文件，fd：跳到函数的定义/声明位置
"Tip：使用ctrl+o向前调，ctrl+i向后跳
map fi :YcmCompleter GoToInclude<CR>
map fd :YcmCompleter GoTo<CR>
"---------------------------------------------------------
"<关于instantmarkdown插件的一些配置>
"---------------------------------------------------------
let g:instant_markdown_autostart = 0  "开启手动启动预览窗口
noremap <C-s> :InstantMarkdownPreview<CR>
noremap <C-e> :InstantMarkdownStop<CR>


"---------------------------------------------------------
"<关于neartree插件的一些配置>
"相当于一个新的窗口，故可以用窗口的操作来控制他
"---------------------------------------------------------

"四个分别是:打开树，打开数，关闭树，打开并显示到当前所在文件位置
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>  
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"当tree是最后一个窗口时，自动关闭
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

