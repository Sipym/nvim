-- ensured_installed server list
local lsp_servers = {
  "lua_ls",
  "pyright",
  "bashls",
  "clangd",
  "html",
  "cssls",
  "jsonls",
  "markdown_oxide",
  "verible",
  "nil_ls",
}

return {
  -- ========================================== --
  -- LSP 服务器、Linter、Formatter 管理 (Mason)
  -- ========================================== --
  {
    "mason-org/mason.nvim",
    cmd = "Mason", -- 仅在执行 :Mason 命令时加载
    opts = {
      -- 在这里列出所有需要 Mason管理的 LSP 服务器、Linter 和 Formatter
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "",
        },
      },
    },
    build = function()
      -- 尝试在安装或更新时运行 MasonUpdate
      pcall(function()
        vim.cmd("MasonUpdate")
      end)
    end,
  },

  -- ========================================== --
  -- Mason 与 nvim-lspconfig 的桥梁
  -- ========================================== --
  {
    "mason-org/mason-lspconfig.nvim",
    -- 依赖关系确保了本插件在 nvim-lspconfig 和 mason.nvim 之后加载
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      -- 在这里列出所有需要 Mason lspconfig管理的 LSP 服务器
      ensure_installed = lsp_servers,
    },
  },

  -- ========================================== --
  -- !! Neovim LSP 核心配置 (nvim-lspconfig)
  -- ========================================== --
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }, -- 在打开文件时触发加载
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp 的 LSP 补全源
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- =========================================================== --
      -- == 全局配置 (应该放在这里，只执行一次) ==
      -- =========================================================== --

      -- 1. 全局诊断 (错误/警告/信息/提示) 的视觉样式配置
      --    这些设置影响所有 LSP 服务器提供的诊断信息显示方式
      vim.diagnostic.config({
        virtual_text = true,            -- 在行尾显示简短诊断信息 (可配置更详细)
        underline = true,               -- 高亮显示有诊断信息的文本
        update_in_insert = true,        -- 插入模式下更新诊断，会降低性能
        severity_sort = true,           -- 按严重性对诊断排序
        float = { border = "rounded" }, -- !!使用这里统一配置诊断浮动窗口边框 ！！
        signs = {
          -- 是否启用行号栏图标显示 (通常为 true)
          active = true,
          -- 定义每个诊断级别的图标和其他属性
          -- 使用 vim.diagnostic.severity 下的常量作为键更标准
          severity = {
            [vim.diagnostic.severity.ERROR] = {
              text = "", -- 图标文本 (需要 Nerd Font)
              texthl = "DiagnosticSignError", -- 图标本身的高亮组
              -- linehl = '',                   -- (可选) 整行的高亮组
              numhl = "DiagnosticSignError", -- (可选) 行号的高亮组
            },
            [vim.diagnostic.severity.WARN] = {
              text = "",
              texthl = "DiagnosticSignWarn",
              numhl = "DiagnosticSignWarn",
            },
            [vim.diagnostic.severity.INFO] = {
              text = "",
              texthl = "DiagnosticSignInfo",
              numhl = "DiagnosticSignInfo",
            },
            [vim.diagnostic.severity.HINT] = {
              text = "󰌵",
              texthl = "DiagnosticSignHint",
              numhl = "DiagnosticSignHint",
            },
          },
        },
      })

      -- =========================================================== --
      -- == 核心 LSP 设置 (on_attach 和 capabilities) ==
      --    这些将作为通用配置传递给每个 LSP 服务器的 setup
      -- =========================================================== --

      -- 2. 定义 LSP 客户端的能力 (Capabilities)
      --    告诉 LSP 服务器 Neovim 客户端支持哪些功能 (如补全、代码操作等)
      --    这里我们获取 nvim-cmp 提供的默认能力，确保补全功能正常工作
      local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- 2.1 添加LSP客户端的能力
      --     为nvim lsp集成nvim-ufo的折叠功能
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      require("ufo").setup()

      -- 3. 定义 on_attach 函数
      --    这个函数会在 LSP 客户端成功附加 (attach) 到一个缓冲区 (buffer) 时执行
      --    这是设置缓冲区局部 (buffer-local) 快捷键和选项的最佳位置
      --    所有 LSP 服务器都将使用这个相同的 on_attach 函数 (除非在 handlers 中被覆盖)
      local on_attach = function(client, bufnr)
        -- client: 代表当前连接的 LSP 服务器客户端对象
        -- bufnr: 当前缓冲区的编号

        -- 定义一个本地快捷键设置函数，简化后续调用
        local map = function(mode, lhs, rhs, desc)
          local opts = { noremap = true, silent = true, buffer = bufnr }
          if desc then
            opts.desc = "LSP: " .. desc -- 添加统一前缀
          end
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- === 设置 LSP 相关快捷键 ===

        -- 跳转 (基础)
        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")           -- 跳转到定义
        map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")         -- 跳转到声明
        map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition") -- 跳转到类型定义
        map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")   -- 跳转到实现

        -- 跳转 (使用 Telescope - 需要安装和配置 telescope.nvim)
        map("n", "grr", function()
          require("telescope.builtin").lsp_references()
        end, "Goto References (Telescope)")
        map("n", "gdn", function()
          require("telescope.builtin").lsp_definitions({ jump_type = "never" })
        end, "Goto Definition (Telescope, No Jump)")
        map("n", "gdv", function()
          require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
        end, "Goto Definition (Telescope, VSplit)")
        map("n", "gds", function()
          require("telescope.builtin").lsp_definitions({ jump_type = "split" })
        end, "Goto Definition (Telescope, Split)")
        map("n", "gdt", function()
          require("telescope.builtin").lsp_definitions({ jump_type = "tab" })
        end, "Goto Definition (Telescope, Tab)")
        map("n", "<leader>vf", function()
          require("telescope.builtin").lsp_definitions({ jump_type = "tab" })
        end, "Goto Definition (Telescope, New Tab)") -- 使用 Telescope 实现跳转到新 Tab

        -- 信息与操作
        map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature Help") -- (插入模式) 显示函数签名帮助
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")  -- 执行代码操作 (修复、重构等)
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")     -- 重命名符号

        -- 诊断信息跳转与显示
        map("n", "<leader>vd", vim.diagnostic.open_float, "Show Line Diagnostics")        -- 浮动窗口显示当前行诊断
        map("n", "<leader>vdl", vim.diagnostic.setloclist, "Show Diagnostics in LocList") -- 将诊断列表放入 location list

        -- 工作区 (Workspace) 相关
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
        map("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "List Workspace Folders")
        map("n", "<leader>vws", function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end, "Workspace Symbols (Telescope)") -- 使用 Telescope 查找工作区符号
      end

      -- =========================================================== --
      -- == 配置 LSP 服务器 (通过 lspconfig) ==
      -- =========================================================== --

      vim.lsp.config('lua_ls',{
        on_attach = on_attach,       -- 仍然使用通用的 on_attach
        capabilities = capabilities, -- 仍然使用通用的 capabilities
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = {
                "vim",
                "require",
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      })
      -- 为每个服务器应用通用配置
      for _, server_name in ipairs(lsp_servers) do
        vim.lsp.config(server_name,{
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      vim.lsp.config('verible',{
        -- verible 的特殊设置 (覆盖 cmd)
        cmd = {
          "verible-verilog-ls",
          "--rules_config",
          vim.fn.expand("~/.config/nvim/Lsp_config/.rules.verible_lint"),
          "--flagfile",
          vim.fn.expand("~/.config/nvim/Lsp_config/verible_format.txt"),
        },
        -- 你也可以在这里覆盖 on_attach 或 capabilities (如果需要)
      })

      vim.lsp.config('markdown_oxide',{
        settings = {
          -- 假设 markdown-oxide 有一个这样的配置选项
          markdown = {
            exclude = { ".obsidian/" }, -- 排除 .obsidian 目录
            -- 或者
            -- ignoreFolders = { ".obsidian" },
          },
          -- 或者更通用的 LSP 工作区设置，但这通常是针对 LSP 根目录的
          -- workspace = {
          --     exclude = { "**/.obsidian/**" },
          -- },
        },
      })

      vim.lsp.config('pyright',{
        settings = {
          python = {
            -- pythonPath = "/path/to/your/venv/bin/python",
          },
          pyright = {
            -- typeCheckingMode = "basic", -- 或 "strict"
          },
        },
      })

      vim.lsp.config('clangd',{
        cmd = {
          "clangd",
          "--clang-tidy",       -- 启用静态检查
          "--header-insertion=never", -- 禁止补全时自动插入头文件
        },
        settings = {
        },
      })
    end,
  },

  -- ========================================== --
  -- 自动补全 (nvim-cmp)
  -- ========================================== --
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- 插入模式时加载
    dependencies = {
      -- 补全源
      "hrsh7th/cmp-nvim-lsp",     -- LSP 来源 (必需)
      "hrsh7th/cmp-buffer",       -- Buffer 文本来源
      "hrsh7th/cmp-path",         -- 文件路径来源
      "hrsh7th/cmp-cmdline",      -- 命令行来源 (可选)
      "saadparwaiz1/cmp_luasnip", -- Snippet 来源 (如果使用 LuaSnip)

      -- Snippet 引擎
      "L3MON4D3/LuaSnip",

      -- (可选) UI 增强
      "onsails/lspkind.nvim", -- 图标美化
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- 补全源列表
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            option = {
              markdown_oxide = {
                -- 使得补全能够支持中文
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
              }
            }
          },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        -- 快捷键映射
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- 上翻文档
          ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- 下翻文档
          ["<C-x>"] = cmp.mapping.complete(),                -- 手动触发补全
          ["<C-e>"] = cmp.mapping.abort(),                   -- 中止补全
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 回车确认选择

          -- Tab/S-Tab 用于在补全项和 Snippet 跳转点之间导航
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }), -- i: 插入模式, s: 选择模式
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- (可选) 格式化补全项，添加图标和来源指示
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.codicons[vim_item.kind] or "?" -- 添加图标
            vim_item.menu = ({                                             -- 添加来源指示
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
      -- (可选) 设置命令行补全
      cmp.setup.cmdline({ "/", "?" }, { -- 搜索命令
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", { -- 普通命令
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- ========================================== --
  -- Snippet 引擎 (LuaSnip)
  -- ========================================== --
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" }, -- 如果你需要通用 snippets
    build = (vim.fn.has("win32") == 0 and vim.fn.executable("make")) and "make install_jsregexp" or nil,
    config = function()
      -- 这会加载 friendly-snippets 提供的所有 snippets (包括 Markdown)
      -- 这些 snippets 通常使用 VS Code snippet 的格式，所以使用 from_vscode 加载器
      require("luasnip.loaders.from_vscode").lazy_load()

      -- 在这里添加你的 LuaSnip 特定配置，例如加载自定义 snippets
      -- require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
    end,
  },

  -- ========================================== --
  -- (依赖) UI 增强插件 (可选但推荐)
  -- ========================================== --
  -- { "j-hui/fidget.nvim", tag = "legacy", opts = {} }, -- LSP 状态显示
  { "onsails/lspkind.nvim" }, -- 补全图标
}
