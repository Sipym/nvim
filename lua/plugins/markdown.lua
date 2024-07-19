-- markdown相关插件
return {
    ----- md-img-paste
    --- 功能:  makrdown:快速的插入图片
    {
        "ferrine/md-img-paste.vim",
        ft = {'markdown',},
        config = function()
            vim.cmd([[
                autocmd FileType markdown nmap <buffer><silent> <space>p :call mdip#MarkdownClipboardImage()<CR>
                " there are some defaults for image directory and image name, you can change them
                " let g:mdip_imgdir = '.'
                " let g:mdip_imgname = 'image'
                "autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
            ]])
        end
    },

}
