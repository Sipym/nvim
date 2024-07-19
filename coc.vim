" ============================================================
" =================关于coc-extension的配置====================
" ============================================================

" =============coc-markdown-preview-enhanced ==================
" 预览界面<esc>用来toggle目录
map <C-s> :CocCommand markdown-preview-enhanced.openPreview<CR>

" =============coc-markmap ==================
" 将你的Markdown想象成带有markmap的思维导图
" 命令:CocCommand markmap.creat
" 命令:CocCommand markmap.watch
"
"
" =============coc-texlab ==================
" 将严格模式设置为 'ignore'，以忽略 LaTeX 不兼容的警告
let g:coc_texlab_latexingore = [
    \ 'unicodeTextInMathMode'
    \]

