-- markdown相关插件
return {
	-- markdown-preview
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
			vim.g.mkdp_theme = "light"
			vim.g.mkdp_combine_preview = 1
		end,
	},

	-- render
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		ft = { "markdown", "codecompanion" },
		opts = {
			completions = { lsp = { enabled = true } },
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			vim.keymap.set("n", "<leader>m", ":RenderMarkdown toggle<CR>", { desc = "Toggle Markdown Render" })
		end,
	},

	-- ========================================== --
	-- obsidian.nvim
	-- ========================================== --
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		-- lazy = true,
		-- ft = "markdown",
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "personal", -- 给你的 vault 起个名字
					path = "~/Documents/notes", -- !! 修改为你的 vault 实际路径 !!
				},
			},
			notes_subdir = "90-Inbox",
			log_level = vim.log.levels.INFO,
			-- 暂时不用他的补全，借用lsp的
			completion = {
				nvim_cmp = false,
				min_chars = 2,
			},
			mappings = {
				-- smart_action
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
			},

			new_notes_location = "notes_subdir",
			preferred_link_style = "wiki",
			disable_frontmatter = false,

			---@param url string
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				local uname = vim.loop.os_uname()
				if uname and uname.sysname then
					if uname.sysname == "Darwin" then
						-- macOS
						vim.fn.jobstart({ "open", url })
					elseif uname.sysname == "Linux" then
						-- Linux
						vim.fn.jobstart({ "xdg-open", url })
					else
						-- Unsupported OS
						print("Unsupported OS: " .. uname.sysname)
					end
				else
					print("Failed to determine OS.")
				end
			end,

			---@param img string
			follow_img_func = function(img)
				local uname = vim.loop.os_uname()
				if uname and uname.sysname then
					if uname.sysname == "Darwin" then
						-- macOS
						vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
					elseif uname.sysname == "Linux" then
						-- Linux
						vim.fn.jobstart({ "xdg-open", img }) -- linux
					else
						-- Unsupported OS
						print("Unsupported OS: " .. uname.sysname)
					end
				else
					print("Failed to determine OS.")
				end
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
			end,

			open_app_foreground = false,
			picker = {
				name = "telescope.nvim",
			},
			sort_by = "modified",
			sort_reversed = true,
			search_max_lines = 1000,
			open_notes_in = "vsplit",
			ui = {
				enable = false,
			},

			-- 生成frontmatter，包括创建时间，更新时间
			note_frontmatter_func = function(note)
				-- 将笔记的标题添加为其别名 (alias) 之一
				if note.title then
					note:add_alias(note.title)
				end
				function GetCreationTimeString()
					local filepath = vim.api.nvim_buf_get_name(0)
					if filepath == "" then
						return nil
					end -- 没有关联文件则返回 nil

					-- 安全地获取文件状态
					local ok, stat = pcall(vim.loop.fs_stat, filepath)

					-- 检查是否成功获取且包含 birthtime 信息
					if ok and stat and stat.birthtime and stat.birthtime.sec then
						-- 直接格式化并返回
						return os.date("%Y-%m-%dT%H:%M:%S", stat.birthtime.sec)
					end

					-- 其他情况（错误、不支持等）返回 nil
					return nil
				end
				-- 获取当前时间 (ISO 8601 UTC 格式)
				local created_time = GetCreationTimeString()
				local current_time = os.date("%Y-%m-%dT%H:%M:%S")

				-- 构建包含基础元数据和创建时间的 Lua 表
				local out = {
					id = note.id, -- 包含由 obsidian.nvim 生成的唯一笔记 ID
					aliases = note.aliases, -- 包含所有别名（包括标题）
					tags = note.tags, -- 包含任何已关联的标签
					created = created_time, -- !! 添加创建时间字段 !!
					updated = current_time,
				}

				-- 保留创建时可能传入的其他元数据
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						-- 确保不覆盖我们已经设置的字段 (以防万一 metadata 里也有 created 等)
						if out[k] == nil then
							out[k] = v
						end
					end
				end

				-- 返回最终构建的 Lua 表
				-- obsidian.nvim 会将其转换为 YAML 格式写入文件
				return out
			end,
			-- 从制定文件夹中选择模板
			templates = {
				folder = "00-Meta",
			},

			attachments = {
				img_folder = "70-Assets/imgs",
			},
      -- 可以添加在官方提供的回调函数中，添加任意行为,如进入notes时，触发某种行为
      callbacks = {
      },
		},
		config = function(_, opts)
			require("obsidian").setup(opts)

      -- 配置键盘映射
      -- stylua: ignore start
      vim.keymap.set('n','<leader>on',"<cmd>ObsidianNew<CR>", {desc = "Obsidian: Create New Note"})
      vim.keymap.set('n','<leader>of',"<cmd>ObsidianQuickSwitch<CR>", {desc = "Obsidian: Search In All vaults By name"})
      vim.keymap.set('n','<leader>og',"<cmd>ObsidianSearch<CR>", {desc = "Obsidian: Search In All vaults By grep"})
      vim.keymap.set('n','<leader>or',"<cmd>ObsidianBacklinks<CR>", {desc = "Obsidian: Back links"})
      vim.keymap.set('n','<leader>ot',"<cmd>ObsidianTags<CR>", {desc = "Obsidian: Search by Tags"})
      vim.keymap.set('n','<leader>oi',"<cmd>ObsidianTemplate<CR>", {desc = "Obsidian: Insert Template"})
      vim.keymap.set('n','<leader>op',"<cmd>ObsidianPasteImg<CR>", {desc = "Obsidian: Paste Image"})
      vim.keymap.set('n','<leader>ol',"<cmd>ObsidianLinks<CR>", {desc = "Obsidian: All Links In Buffer"})
      vim.keymap.set('n','<leader>oe',"<cmd>ObsidianExtractNote<CR>", {desc = "Obsidian: Move the Visualed To new notes and Link it"})
			-- stylua: ignore end
		end,
	},
}
