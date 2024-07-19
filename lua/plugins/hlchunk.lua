--- 功能:  chunk,indentline,blank

-- 太卡了
return {
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
        require("hlchunk").setup({
            chunk = {
                  enable = false,
                  style = {
                      { fg = "#806d9c" }, -- 紫罗兰紫
                      --{ fg = "#c21f30" }, -- 红色
                  },
            },
            indent = {
                enable = false,
                chars = {
                    "│",
                },
                style = {
                    vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
                },
            },
            line_num = {
                enable = false,
                style = {
                    { fg = "#806d9c" }, -- 紫罗兰紫
                    --{ fg = "#c21f30" }, -- 红色
                },
            },
        })
        local default_conf = {
            enable = false,
            style = {},
            notify = false,
            priority = 0,
            exclude_filetypes = {
                aerial = true,
                dashboard = true,
                -- some other filetypes
            }
        }
      end
    },
}
