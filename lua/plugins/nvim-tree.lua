return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        -- 自定义文件树界面的按键映射
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true,
                }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', 'J', function()
                for i = 1, 5 do
                    api.node.navigate.sibling.next()
                end
            end, opts('Next 5 Sibling'))
            vim.keymap.set('n', 'K', function()
                for i = 1, 5 do
                    api.node.navigate.sibling.prev()
                end
            end, opts('Previous 5 Sibling'))
            -- 这些没有修改，起提示作用
            vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
            vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        end

        -- pass to setup along with your other options
        require("nvim-tree").setup {
            ---
            on_attach = my_on_attach,
            ---
            filters = {
                enable = true,
                git_ignored = false,
                dotfiles = false,
                git_clean = false,
                no_buffer = false,
                no_bookmark = false,
                custom = {},
                exclude = {},
            },
        }
        vim.cmd([[
            map <leader>e :NvimTreeToggle<CR>
        ]])
    end,
}
