return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
            win = {
                -- don't allow the popup to overlap with the cursor
                no_overlap = true,
                --width = 100,
                height = { min = 4, max = 50 },
                -- col = 0,
                -- row = math.huge,
                -- border = "none",
                padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
                title = true,
                title_pos = "center",
                zindex = 1000,
                -- Additional vim.wo and vim.bo options
                bo = {},
                wo = {
                    -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                },
            },
            layout = {
                width = { min = 20 }, -- min and max width of the columns
                spacing = 3,          -- spacing between columns
            },
        },
    },
}
