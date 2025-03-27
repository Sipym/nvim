return {
  -- lint工具
  ---  适用于于没有LSP，或者独立linter(如verilog的verilator)效果更好的语言。
  ---  暂时没用到
  {
    "mfussenegger/nvim-lint",
    ft = {
      "verilog",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
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
      end, { desc = "Trigger linting for current file" }
      )
    end,
  },

  --  格式化工具 conform
  --  操作方式:  <leader>l
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          verilog = { "verible", },
          c = { "clang-format" },
          cpp = { "clang-format" },
          lua = { "stylua" },
          --javascript = { { "prettierd", "prettier" } },
          --javascriptreact = { { "prettierd", "prettier" } },
          --json = { { "prettierd", "prettier" } },
          --java = { "google-java-format" },
          --markdown = { "prettierd", "prettier" },
          --html = { "htmlbeautifier" },
          --bash = { "beautysh" },
          --yaml = { "yamlfix" },
          sh = { { "shellcheck" } },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>l", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
