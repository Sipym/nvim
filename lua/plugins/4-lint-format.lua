return {
	-- ========================================== --
	-- Linting 工具 (nvim-lint)
	-- ========================================== --
	{
		"mfussenegger/nvim-lint",
		ft = { "sh" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				--verilog = { "verilator" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},

	--  格式化工具 conform
	--  操作方式:  <leader>lf
	{
		"stevearc/conform.nvim",
		-- 依赖 Mason 来安装 formatters
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" }, -- 或者 "VeryLazy"
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					verilog = { "verible" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					lua = { "stylua" },
					sh = { "shfmt" },
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>lf", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},

	-- 手动格式工具
	-- gl/L + '/‘，可以进入匹配字符的模式
	-- gl+字符，按字符，右对齐
	-- gL+字符，按字符，左对齐
	{
		"tommcdo/vim-lion",
	},
}
