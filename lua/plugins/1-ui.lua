-- 编辑器界面视觉组件
return {
	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "gruvbox",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename", "lsp_status" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},

	-- -- bufferline
	-- {
	--   'akinsho/bufferline.nvim',
	--   version = "*",
	--   dependencies = 'nvim-tree/nvim-web-devicons',
	--   opts = {
	--     options = {
	--       mode = "buffers",
	--     }
	--   },
	-- },

	--hlchunk
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
		end,
	},

	-- mini-icon
	{
		"echasnovski/mini.nvim",
		version = false,
	},

	-- nvim-web-devicons
	{
		"nvim-tree/nvim-web-devicons",
	},

	-- which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			win = {
				-- don't allow the popup to overlap with the cursor
				no_overlap = true,
				--width = 100,
				height = { min = 4, max = 50 },
				-- col = 0,
				-- row = math.huge,
				-- border = "none",
				padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
				title = true,
				title_pos = "center",
				zindex = 1000,
				-- Additional vim.wo and vim.bo options
				bo = {},
				wo = {
					-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				},
			},
			layout = {
				width = { min = 20 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
			},
		},
	},

	-- aerial 大纲
	-- {
	-- 	"stevearc/aerial.nvim",
	-- 	opts = {},
	-- 	-- Optional dependencies
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("aerial").setup({
	-- 			layout = {
	-- 				max_width = { 40, 0.2 },
	-- 				width = nil,
	-- 				min_width = 25,
	-- 				default_direction = "prefer_left",
	-- 			},
	--
	-- 			close_automatic_events = { "switch_buffer" },
	--
	-- 			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	-- 			on_attach = function(bufnr)
	-- 				-- Jump forwards/backwards with '{' and '}'
	-- 				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
	-- 				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	-- 			end,
	-- 		})
	-- 		-- You probably also want to set a keymap to toggle aerial
	-- 		vim.keymap.set("n", "<leader>t", "<cmd>AerialToggle!<CR>")
	-- 	end,
	-- },

	-- nvim-tree
	{
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
				local api = require("nvim-tree.api")

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
				vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "J", function()
					for i = 1, 5 do
						api.node.navigate.sibling.next()
					end
				end, opts("Next 5 Sibling"))
				vim.keymap.set("n", "K", function()
					for i = 1, 5 do
						api.node.navigate.sibling.prev()
					end
				end, opts("Previous 5 Sibling"))
				-- 这些没有修改，起提示作用
				vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
				vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			end

			-- pass to setup along with your other options
			require("nvim-tree").setup({
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
			})
			vim.cmd([[
            map <leader>e :NvimTreeToggle<CR>
        ]])
		end,
	},

	-- nvim-notify
	-- lua/plugins/notify.lua (或者你的插件配置文件)
	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	opts = {
	-- 		level = vim.log.levels.INFO, -- 最低显示级别
	-- 		timeout = 4000, -- 默认超时时间 (毫秒)
	-- 		fps = 60,
	--      background_colour = vim.fn.hlexists("NormalFloat") > 0 and "NormalFloat" or "Normal",
	-- 	},
	-- 	config = function(_, opts)
	-- 		-- 非常重要的一步：让 nvim-notify 接管 vim.notify
	-- 		vim.notify = require("notify")
	-- 		-- 应用配置
	-- 		require("notify").setup(opts)
	--
	-- 		-- (可选) 设置 Telescope 集成，用于查看通知历史
	-- 		local telescope_ok, telescope = pcall(require, "telescope")
	-- 		if telescope_ok then
	-- 			telescope.load_extension("notify")
	-- 			vim.keymap.set("n", "<leader>fn", function() -- un: user notify
	-- 				telescope.extensions.notify.notify()
	-- 			end, { desc = "查看通知历史" })
	-- 		end
	-- 	end,
	-- },

	-- noice.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		module = "noice",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
			},
			messages = {
				enabled = false,
			},
			popupmenu = {
				enabled = true,
				backend = "nui",
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = false,
				},
				hover = { enabled = true },
				signature = { enabled = true },
				-- 没有单独设置signature,hover时，都会用documentation的配置
				documentation = { -- 这个部分定义了 hover 和 signature 的默认视图和选项
					view = "hover", -- 定义默认视图名
				},
			},

			-- 所有视图配置都在views中设置就行，然后其他各个块，只用选择选用那种视图就行。
			--- 如果想要单独配置，就到各个块里单独设置就行
			views = {
				cmdline_popup = {
					position = {
						row = 20,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				hover = {
					border = {
						style = "rounded",
					},
					position = { row = 2, col = 0 },
				},
			},

			presets = {
				bottom_search = true,
				command_palette = true,
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function(_, opts)
			require("noice").setup(opts)
			require("notify").setup({
				background_colour = vim.fn.hlexists("NormalFloat") > 0 and "NormalFloat" or "Normal",
			})
			vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end, { silent = true, expr = true })

			vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end, { silent = true, expr = true })
		end,
	},

	-- TODO comment
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- NOTE: 这里需要调用require，保证该插件在加载文件前加载
			require("todo-comments").setup()
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "Next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "Previous todo comment" })
		end,
	},

	-- 更好看的诊断信息
  {
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
        options = {
          -- 能够同时看到多个诊断
          multilines = {
            enabled = true,
          },
        }

      })
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},
}
