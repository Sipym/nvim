-- LSP安装与配置 + 代码补全
return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- LSP安装工具
				"williamboman/mason.nvim",
				build = function()
					pcall(function()
						vim.cmd("MasonUpdate")
					end)
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required

			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lsp = require("lsp-zero")

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.references()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))

				vim.keymap.set("n", "gdn", function()
					require("telescope.builtin").lsp_definitions({ jump_type = "never" })
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition (never)" }))

				vim.keymap.set("n", "gdv", function()
					require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition (vsplit)" }))

				vim.keymap.set("n", "gds", function()
					require("telescope.builtin").lsp_definitions({ jump_type = "split" })
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition (split)" }))

				vim.keymap.set("n", "gdt", function()
					require("telescope.builtin").lsp_definitions({ jump_type = "tab" })
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition (tab)" }))

				vim.keymap.set("n", "<leader>vf", function()
					--vim.cmd ([[:leftabove vsplit]])
					vim.cmd([[:tab sp]])
					vim.lsp.buf.definition()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition in new window" }))

				vim.keymap.set("n", "<leader>vs", function()
					vim.lsp.buf.hover()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" })) -- 查看符号信息,如函数定义的注释等

				vim.keymap.set(
					"n",
					"<leader>vws",
					function()
						vim.lsp.buf.workspace_symbol()
					end, -- 查看工作去符号信息
					vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" })
				)

				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.setloclist()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))

				vim.keymap.set(
					"n",
					"<leader>vca",
					function()
						vim.lsp.buf.code_action()
					end, -- 根据诊断信息来修复代码
					vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" })
				)

				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" })) -- 类似gr

				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))

				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))

				-- 诊断信息相关的设置
				vim.diagnostic.config({
					virtual_text = true, -- 在行尾显示错误信息
					signs = true, -- 显示诊断标志（图标）
					underline = true, -- 错误行下划线
					update_in_insert = true, --输入模式下也可以检查错误
					severity_sort = true,
				})
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"markdown_oxide", -- nvim Obsidian Lsp,能够提供文件间跳转,并且支持双向链接
					"lua_ls",
					--"tsserver",
					"html",
					"pylsp",
					"bashls",
					"clangd",
					"verible",
				},
				handlers = {
					lsp.default_setup,
					lua_ls = function()
						local lua_opts = lsp.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
				},
			})
			-- ===============================================
			-- 配置各个lsp的方式，这是配置verible
			-- ===============================================
			require("lspconfig").verible.setup({
				cmd = {
					"verible-verilog-ls",
					"--rules_config",
					"~/.config/nvim/Lsp_config/.rules.verible_lint",
					"--flagfile",
					"~/.config/nvim/Lsp_config/verible_format.txt",
				},
			})

			---------------end--------------------------------

			local cmp_action = require("lsp-zero").cmp_action()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			require("luasnip.loaders.from_vscode").lazy_load()

			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					--{ name = 'ultisnips' },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 2 },
					{ name = "path" },
					{ name = "render-markdown" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
					["<Tab>"] = cmp_action.luasnip_supertab(),
					["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
				}),
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip", -- lsp Autocompletion Required
		build = "make install_jsregexp",
	},
}
