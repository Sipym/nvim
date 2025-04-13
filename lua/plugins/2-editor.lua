-- 增强编辑体验
return {
	-- comment
	{
		"numToStr/Comment.nvim",
		opts = {
			---Add a space b/w comment and the line
			padding = true,
			---Whether the cursor should stay at its position
			sticky = true,
			---Lines to be ignored while (un)comment
			ignore = nil,
			---LHS of toggle mappings in NORMAL mode
			toggler = {
				---Line-comment toggle keymap
				line = "gcc",
				---Block-comment toggle keymap
				block = "gbc",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment keymap
				line = "gc",
				---Block-comment keymap
				block = "gb",
			},
			---LHS of extra mappings
			extra = {
				---Add comment on the line above
				above = "gcO",
				---Add comment on the line below
				below = "gco",
				---Add comment at the end of line
				eol = "gcA",
			},
			---Enable keybindings
			---NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = false,
			},
			---Function to call before (un)comment
			pre_hook = nil,
			---Function to call after (un)comment
			post_hook = nil,
		}, -- add any options here
	},

	-- nvim-surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- undotree
	{
		"mbbill/undotree",
		config = function()
			vim.cmd([[
        nnoremap <F5> :UndotreeToggle<CR>
        "将撤销文件存储在一个单独的位置
        if has("persistent_undo")
           let target_path = expand('~/.undodir')

            " create the directory and any parent directories
            " if the location does not exist.
            if !isdirectory(target_path)
                call mkdir(target_path, "p", 0700)
            endif

            let &undodir=target_path
            set undofile
        endif
        ]])
		end,
	},

	-- zen mode
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "ZenMode" })
		end,
	},

	-- flash 快速导航
	{
		"folke/flash.nvim",
		-- lazy = false, -- Flash 通常希望在需要时立即响应，可以不设置 lazy 或设为 false
		-- 或者使用事件触发，但按键触发通常足够
		event = "VeryLazy", -- 或者在按键映射中直接 require
		---@type Flash.Config
		opts = {
			-- 这里可以放置 Flash 的配置选项来自定义行为
			-- 例如：修改标签的外观
			-- label = {
			--   uppercase = false, -- 使用小写字母作为标签
			--   -- distance = true, -- 根据距离调整标签颜色 (可能需要调整高亮组)
			-- },
			-- 例如：修改模式
			-- modes = {
			--   -- 禁用某些模式或修改它们的选项
			--   char = {
			--     enabled = true,
			--     multi_line = true,
			--     keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", -- 用于标签的字符
			--   }
			-- },
		},
		-- (可选) 如果你想覆盖 Flash 提供的默认键位或确保它在 setup 后执行
		config = function(_, opts)
			-- 调用 setup (通常不是严格必需，除非你想在 setup 时传入特殊参数)
			-- require("flash").setup(opts)

			-- =============================================== --
			-- == 推荐的 Flash 快捷键映射 ==
			-- =============================================== --
			-- 核心跳转功能：按 's'，然后输入目标字符，然后按显示的标签跳转
			-- 适用于 Normal, Visual, Operator-pending 模式
			vim.keymap.set({ "n", "x", "o" }, "s", function()
				require("flash").jump()
			end, { desc = "Flash Jump" })

			-- 'S' 用于反向跳转 (类似内置的 f/F, t/T)
			vim.keymap.set({ "n", "x", "o" }, "S", function()
				require("flash").jump({ search = { forward = false } }) -- 设置为反向搜索
			end, { desc = "Flash Jump Backward" })

			-- (推荐) 使用 Flash 来增强 Treesitter 跳转 (需要 nvim-treesitter)
      -- 用于快速选择需要的块visual block
			vim.keymap.set("o", "<leader>vb", function()
				require("flash").treesitter()
			end, { desc = "Flash Treesitter" })
			vim.keymap.set("x", "<leader>vb", function()
				require("flash").treesitter({ node_type = true })
			end, { desc = "Flash Treesitter (Node Type)" }) -- Visual模式下可看到节点类型
			vim.keymap.set("n", "<leader>vb", function()
				require("flash").treesitter({ node_type = true })
			end, { desc = "Flash Treesitter (Node Type)" }) -- Normal模式下触发

			-- (可选) 使用 Flash 来跳转到搜索结果
			-- 按 'f' 跳转到下一个搜索匹配项 (使用 flash 标签)
			vim.keymap.set({ "n", "x", "o" }, "f", function()
				require("flash").jump({ pattern = vim.fn.getreg("/") })
			end, { desc = "Flash to Search Pattern (Forward)" })
			-- 按 'F' 跳转到上一个搜索匹配项 (使用 flash 标签)
			vim.keymap.set({ "n", "x", "o" }, "F", function()
				require("flash").jump({ pattern = vim.fn.getreg("/"), search = { forward = false } })
			end, { desc = "Flash to Search Pattern (Backward)" })
		end,
	},
}
