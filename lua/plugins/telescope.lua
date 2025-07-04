return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end,  desc = 'Live grep' },
      { '<leader>fb', function() require('telescope.builtin').buffers() end,    desc = 'Buffers' },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end,  desc = 'Help tags' },
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'sharkdp/fd' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require("telescope").setup({
        defaults = {

          layout_strategy = 'vertical',
          layout_config = {
            width = 0.6,
          },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          }
        },
      })
      vim.keymap.set("n", "<leader>fn", function() -- un: user notify
        require("telescope").extensions.notify.notify()
      end, { desc = "查看通知历史" })
    end,
  },
}
