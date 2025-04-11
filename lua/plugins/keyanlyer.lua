return {
  -- 用于寻找空闲的映射
  {
    "meznaric/key-analyzer.nvim",
    opts = {},
    config = function()
      require("key-analyzer").setup({
        -- Name of the command to use for the plugin
        command_name = "KAnalyzer", -- or nil to disable the command
      })
    end
  },
}
