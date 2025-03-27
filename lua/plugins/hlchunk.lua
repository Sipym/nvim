--- 功能:  chunk,indentline,blank

return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- 需要打开文件时，立即加载配置，所以用setup
      require("hlchunk").setup({
        indent = {
          enable = true,
          chars = {
            "│",
          },
          style = {
            "#A6C48A",
            "#C6B3E5",
          },
        },
      })
    end
  },
}
