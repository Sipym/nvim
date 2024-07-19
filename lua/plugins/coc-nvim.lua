--- 功能:  coc相关插件(非常重要)

return {
    {
        "neoclide/coc.nvim",
        branch = 'release', -- 指定分支
        config = function()
            vim.cmd([[
                source ~/.config/nvim/coc.vim
                "当变量中包含的扩展名没有被安装的时候，安装那些扩展“
                "`coc-snippets`为coc补全建议中还添加了snippets片段的支持  
                let g:coc_global_extensions = [ 
                        \ 'coc-json',
                        \ 'coc-html',
                        \ 'coc-highlight',
                        \ 'coc-git',
                        \ 'coc-clang-format-style-options',
                        \ 'coc-cmake',
                        \ 'coc-markdown-preview-enhanced',
                        \ 'coc-texlab',
                        \ 'coc-explorer',
                        \ 'coc-markmap',
                        \ 'coc-webview',
                        \ 'coc-vimlsp',
                        \ 'coc-diagnostic', 
                        \ 'coc-snippets',
                		\ 'coc-clangd',]
                
                set nobackup
                set nowritebackup
                set signcolumn=yes
                "设置coc的使用的node所在目录
                let g:coc_node_path = "/home/awjl/.local/node/bin/node"
                
                "----------------tab cofig -------------------------
                "使用tab来选择代码不全的选择
                function! CheckBackspace() abort
                  let col = col('.') - 1
                  return !col || getline('.')[col - 1]  =~# '\s'
                endfunction
                inoremap <silent><expr> <Tab>
                      \ coc#pum#visible() ? coc#pum#next(1) :
                      \ CheckBackspace() ? "\<Tab>" :
                      \ coc#refresh()
                "tab向下选择，shift+tab向上选择
                inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
                
                "------tab config end-----
                
                "Make <CR> to accept selected completion item or notify coc.nvim to format
                "<C-g>u breaks current undo, please make your own choice.
                "使用enter来选择提供的第一个补全
                inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
                
                function! CheckBackspace() abort
                  let col = col('.') - 1
                  return !col || getline('.')[col - 1]  =~# '\s'
                endfunction
                
                "使用[g，]g来跳转到下/上个报错的地方
                nmap <silent> [g <Plug>(coc-diagnostic-prev)
                nmap <silent> ]g <Plug>(coc-diagnostic-next)
                "显示所有诊断
                nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
                
                "跳转到函数,变量定义处
                nmap <silent> gd <Plug>(coc-definition)  
                "在新窗口中打开函数，变量定义
                nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
                "显示所有当前文件中使用光标所在处函数的位置,可跳转
                nmap <silent> gr <Plug>(coc-references)
                
                "重命名变量，该变量所在的所有行的名字都会更改
                nmap <leader>rn <Plug>(coc-rename)
                
                "格式化代码，使代码符合书写规范
                xmap <leader>f  <Plug>(coc-format-selected)
                nmap <leader>f  <Plug>(coc-format-selected)
                
                augroup mygroup
                  autocmd!
                  "自动识别文件类型 
                  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
                   "Update signature help on jump placeholder.
                  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
                augroup end
                
                " Use <leader>p to show documentation in preview window
                function! s:show_documentation()
                  if (index(['vim','help'], &filetype) >= 0)
                    execute 'h '.expand('<cword>')
                  else
                    call CocAction('doHover')
                  endif
                endfunction
                nnoremap <silent> <leader>p :call <SID>show_documentation()<CR>
                
                
                
                
                "----------------一些映射---------------
                "插件管理
                nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
                "显示所有coc命令 
                nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
                "在当前文件中寻找symbol
                nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
                "寻找整个工作目录中某个变量，函数…… 
                nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
                
                
                
                "======================关于coc-explorer插件的一些配置=======================
                
                "文件浏览的一些预设目录
                let g:coc_explorer_global_presets = {
                \   'init.vim': {
                \     'root-uri': '~/.config/nvim',
                \   },
                \   'notes': {
                \     'root-uri': '~/notes/',
                \   },
                \   'home': {
                \     'root-uri': '~/',
                \   },
                \   'workspace': {
                \     'root-uri': '~/workspace/',
                \   },
                \   'tab': {
                \     'position': 'tab',
                \     'quit-on-open': v:true,
                \   },
                \   'tab:$': {
                \     'position': 'tab:$',
                \     'quit-on-open': v:true,
                \   },
                \   'floating': {
                \     'position': 'floating',
                \     'open-action-strategy': 'sourceWindow',
                \   },
                \   'floatingTop': {
                \     'position': 'floating',
                \     'floating-position': 'center-top',
                \     'open-action-strategy': 'sourceWindow',
                \   },
                \   'floatingLeftside': {
                \     'position': 'floating',
                \     'floating-position': 'left-center',
                \     'floating-width': 50,
                \     'open-action-strategy': 'sourceWindow',
                \   },
                \   'floatingRightside': {
                \     'position': 'floating',
                \     'floating-position': 'right-center',
                \     'floating-width': 50,
                \     'open-action-strategy': 'sourceWindow',
                \   },
                \   'simplify': {
                \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
                \   },
                \   'buffer': {
                \     'sources': [{'name': 'buffer', 'expand': v:true}]
                \   },
                \ }
                
                "打开当前所在目录
                "--reveal-when-open选项是打开explorer时，将目录展开导当前文件目录下,
                "也可通过在explorer下输入gs跳转到当前文件所在目录并展开  
                nmap <leader>e :CocCommand explorer --reveal-when-open <CR>
                "打开nvim配置目录
                nmap <space>ei <Cmd>CocCommand explorer --preset init.vim<CR>
                "浮动窗口
                nmap <space>ef <Cmd>CocCommand explorer --preset floating<CR>
                "查看buffer（个人理解就是当前vim打开的所有文件）
                nmap <space>eb <Cmd>CocCommand explorer --preset buffer<CR>
                
                nmap <space>en <Cmd>CocCommand explorer --preset notes<CR>
                nmap <space>ew <Cmd>CocCommand explorer --preset workspace<CR>
                nmap <space>eh <Cmd>CocCommand explorer --preset home<CR>
                
                "显示所有的preset
                nmap <space>el <Cmd>CocList explPresets<CR>
            ]])
        end
    }
}
