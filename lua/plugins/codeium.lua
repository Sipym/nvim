return {
    {
        --'Exafunction/codeium.vim',
        --event = 'BufEnter',
        --config = function()
            --vim.g.codeium_disable_bindings = 1
            ---- Change '<C-g>' here to any keycode you like.
            --vim.keymap.set('i', '<C-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
            --vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                --{ expr = true, silent = true })
            --vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
                --{ expr = true, silent = true })
            --vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
            --vim.cmd([[
                --" 为指定类型启用codeium
                --" let g:codeium_enabled = v:true
                --let g:codeium_filetypes_disabled_by_default = v:true
                
                --let g:codeium_filetypes = {
                    --\ "lua": v:true,
                    --\ "c": v:true,
                    --\ "cpp": v:true,
                    --\ "verilog": v:true,
                    --\ }
                --let g:codeium_manual = v:true
                
                --" You might want to use `CycleOrComplete()` instead of `CycleCompletions(1)`.
                --" This will make the forward cycling of suggestions also trigger the first
                --" suggestion manually.
                --"imap <C-;> <Cmd>call codeium#CycleOrComplete()<CR>
            --]])
        --end
    }
}
