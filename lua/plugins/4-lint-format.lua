return {
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
