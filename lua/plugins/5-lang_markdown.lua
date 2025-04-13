-- markdown相关插件
return {
	----- md-img-paste
	--- 功能:  makrdown:快速的插入图片
	{
		"ferrine/md-img-paste.vim",
		ft = { "markdown" },
		config = function()
			vim.cmd([[
                autocmd FileType markdown nmap <buffer><silent> <space>p :call mdip#MarkdownClipboardImage()<CR>
                " there are some defaults for image directory and image name, you can change them
                " let g:mdip_imgdir = '.'
                " let g:mdip_imgname = 'image'
                "autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
            ]])
		end,
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
			vim.g.mkdp_theme = "light"
			vim.g.mkdp_combine_preview = 1
		end,
	},

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

}
