--- 功能:  代码异步检查( 我用于verilog 语法检测)
return {
    {
        'neovim/nvim-lspconfig',
        lazy = true, -- 暂时不加载
        config = function()
            local lspconfig = require('lspconfig')
            -- Configure LSP servers here
            lspconfig.pyright.setup{}  -- Example for Python
            lspconfig.tsserver.setup{} -- Example for TypeScript/JavaScript
        end
    },
}
