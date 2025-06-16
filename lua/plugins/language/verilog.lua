return {
  {
    "dense-analysis/ale",
    ft = { 'verilog', },
    config = function()
      vim.cmd([[
        let g:airline#extensions#ale#enabled = 1
        let g:ale_linters_explicit = 1
        let g:ale_linters = {
        \   'verilog': ['verilator'],
        \}
        "为ale对verilog进行语法检查时，添加一些参数
        let g:ale_verilog_verilator_options = '--timing'
      ]])
    end
  },
  -- 用法:gbi(
  {
    'antoinemadec/vim-verilog-instance',
    ft = { 'verilog' },
  },
}
