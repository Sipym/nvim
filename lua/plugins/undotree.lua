--- 功能:  可以查看当前文件所有的撤销版本

return {
    {
        "mbbill/undotree",
        config = function()
            vim.cmd([[
                nnoremap <F5> :UndotreeToggle<CR>
                
                "将撤销文件存储在一个单独的位置
                if has("persistent_undo")
                   let target_path = expand('~/.undodir')
                
                    " create the directory and any parent directories
                    " if the location does not exist.
                    if !isdirectory(target_path)
                        call mkdir(target_path, "p", 0700)
                    endif
                
                    let &undodir=target_path
                    set undofile
                endif
            ]])
        end
    }
}
