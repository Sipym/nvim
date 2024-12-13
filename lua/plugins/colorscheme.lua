return {
    { "ellisonleao/gruvbox.nvim", 
        priority = 1000 , 
        config = function()
        -- 在 init.lua 中
        vim.o.termguicolors = true
            require("gruvbox").setup({
              terminal_colors = true, -- add neovim terminal colors
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
              inverse = true, -- invert background for search, diffs, statuslines and errors
              contrast = "hard", -- can be "hard", "soft" or empty string
              palette_overrides = {
                },
              overrides = {
              },
              dim_inactive = false,
              transparent_mode = false,
            })

        end
    },
    {
        'shaunsingh/nord.nvim',
        priority = 1000,
        config = function()
            -- 支持标题,需要插件，懒得弄
            
            --require("headlines").setup({
                --markdown = {
                    --headline_highlights = {
                        --"Headline1",
                        --"Headline2",
                        --"Headline3",
                        --"Headline4",
                        --"Headline5",
                        --"Headline6",
                    --},
                    --codeblock_highlight = "CodeBlock",
                    --dash_highlight = "Dash",
                    --quote_highlight = "Quote",
                --},
            --})
        end
    },
}
