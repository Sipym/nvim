--- 功能:  coc相关插件(不再使用了之后)

return {
    {
        "neoclide/coc.nvim",
        branch = 'release', -- 指定分支
        config = function()
            vim.cmd([[
                source ~/.config/nvim/coc.vim
                "当变量中包含的扩展名没有被安装的时候，安装那些扩展“
                "`coc-snippets`为coc补全建议中还添加了snippets片段的支持  
                "let g:coc_global_extensions = [ 
                "        \ 'coc-json',
                "        \ 'coc-html',
                "        \ 'coc-highlight',
                "        \ 'coc-git',
                "        \ 'coc-clang-format-style-options',
                "        \ 'coc-cmake',
                "        \ 'coc-markdown-preview-enhanced',
                "        \ 'coc-texlab',
                "        \ 'coc-explorer',
                "        \ 'coc-markmap',
                "        \ 'coc-webview',
                "        \ 'coc-vimlsp',
                "        \ 'coc-diagnostic', 
                "        \ 'coc-snippets',
                "		\ 'coc-clangd',]
                let g:coc_global_extensions = [ 
                        \ 'coc-markdown-preview-enhanced',
                        \ 'coc-texlab',
                        \ 'coc-markmap',]
                
                "设置coc的使用的node所在目录
                let g:coc_node_path = "/home/awjl/.local/node/bin/node"
            ]])
        end
    }
}
