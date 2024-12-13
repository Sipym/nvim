return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        keys = {
            { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
            { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Live grep' },
            { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
            { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Help tags' },
        },
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'sharkdp/fd' },
            {'nvim-tree/nvim-web-devicons'},
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
        },
        config = function()
            require("telescope").setup()
        end,
    },
    -- 为telescope服务
}
