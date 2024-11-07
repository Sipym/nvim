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
          enable = true,
          chars = {
            "│",
          },
          style = {
            "#A6C48A",
            --"#AB92Bf",
            "#C6B3E5",

            --"#81D2C7",
            --"#F79824",
            --"#AB92Bf",
            --"#566E3D",
            --"#A72211",
            --"#0E103D",
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
