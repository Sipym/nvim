return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      -- 在 init.lua 中
      -- 先保证了允许
      vim.o.termguicolors = true
      require("gruvbox").setup({ --可以在加载插件时，就能加载这些配置
        terminal_colors = true,       -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,          -- invert background for search, diffs, statuslines and errors
        contrast = "hard",       -- can be "hard", "soft" or empty string
        palette_overrides = {
        },
        overrides = {
        },
        dim_inactive = false,
        transparent_mode = false,
      })
    end
  },
}
