return {
    {
        'tomasky/bookmarks.nvim',
        --lazy = function()
            ---- 获取当前缓冲区的文件名
            --local file = vim.api.nvim_buf_get_name(0)
            ---- 获取文件大小
            --local size = vim.fn.getfsize(file)
            ---- 如果文件大小超过 1MB，禁用该插件
            --if size > 1048576 then
                --return true
            --else
                --return false
            --end
        --end,
        config = function()
            require('bookmarks').setup({
                -- sign_priority = 8,  --set bookmark sign priority to cover other sign
                save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
                keywords = {
                    ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
                    ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
                    ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
                    ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
                },
                on_attach = function(bufnr)
                    local bm = require "bookmarks"
                    local map = vim.keymap.set
                    map("n", "mm", bm.bookmark_toggle)    -- add or remove bookmark at current line
                    map("n", "mi", bm.bookmark_ann)       -- add or edit mark annotation at current line
                    map("n", "mc", bm.bookmark_clean)     -- clean all marks in local buffer
                    map("n", "mn", bm.bookmark_next)      -- jump to next mark in local buffer
                    map("n", "mp", bm.bookmark_prev)      -- jump to previous mark in local buffer
                    map("n", "ml", bm.bookmark_list)      -- show marked file list in quickfix window
                    map("n", "mx", bm.bookmark_clear_all) -- removes all bookmarks
                end
            })
        end
    }
}
