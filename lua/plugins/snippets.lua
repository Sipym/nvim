--- 功能: 添加片段
return {
    {
        "SirVer/ultisnips",
        config = function()
            vim.cmd([[
                let g:UltiSnipsExpandTrigger="<c-t>"
                let g:UltiSnipsJumpForwardTrigger="<c-b>"
                let g:UltiSnipsJumpBackwardTrigger="<c-z>"
                "查看当前文件格式的片段
                map <leader>u :UltiSnipsEdit<CR>
                ""查看当前文件格式的片段时，选择打开一个新窗口
                let g:UltiSnipsEditSplit="tabdo"
            ]])
        end
    },
    {
        "honza/vim-snippets",
        --config = function()
            --vim.cmd([[
            --]])
        --end
    }
}

