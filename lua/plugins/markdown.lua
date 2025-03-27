-- markdown相关插件
return {
  ----- md-img-paste
  --- 功能:  makrdown:快速的插入图片
  {
    "ferrine/md-img-paste.vim",
    ft = { 'markdown', },
    config = function()
      vim.cmd([[
                autocmd FileType markdown nmap <buffer><silent> <space>p :call mdip#MarkdownClipboardImage()<CR>
                " there are some defaults for image directory and image name, you can change them
                " let g:mdip_imgdir = '.'
                " let g:mdip_imgname = 'image'
                "autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
            ]])
    end
  },
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
    end,
    ft = { "markdown" },
    -- 绑定快捷键映射
    keys = {
      { "<C-s>", "<cmd>MarkdownPreview<cr>", desc = "打开markdown 预览" },
    },
    config = function()
      vim.g.mkdp_theme = 'light'
      vim.g.mkdp_combine_preview = 1
    end
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    ft = { "markdown", "codecompanion" },
    opts = {
      completions = { lsp = { enabled = true } },
    },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      dir = "~/",
      notes_subdir = "notes",
      log_level = vim.log.levels.INFO,
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      new_notes_location = "current_dir",
      preferred_link_style = "wiki",
      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({ "open", url }) -- Mac OS
        vim.fn.jobstart({ "xdg-open", url }) -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        -- vim.ui.open(url) -- need Neovim 0.10.0+
      end,

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
      -- file it will be ignored but you can customize this behavior here.
      ---@param img string
      follow_img_func = function(img)
        -- vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
        vim.fn.jobstart({ "xdg-open", img }) -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      end,

      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = false,

      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
      },
      sort_by = "modified",
      sort_reversed = true,
      search_max_lines = 1000,
      open_notes_in = "vertical",
      ui = {
        enable = false,
      },
    },
  }
}
