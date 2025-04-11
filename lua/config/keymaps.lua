local keymap = vim.keymap -- 方便后续调用

-- 使用 J/H/L 进行多行/多列移动, K用于LSP了
-- keymap.set({ "n", "v" }, "J", "5j", { noremap = true, silent = true, desc = "向下移动 5 行" })
-- keymap.set({ "n", "v" }, "K", "5k", { noremap = true, silent = true, desc = "向上移动 5 行" })
-- keymap.set({ "n", "v" }, "H", "5h", { noremap = true, silent = true, desc = "向左移动 5 列" })
-- keymap.set({ "n", "v" }, "L", "5l", { noremap = true, silent = true, desc = "向右移动 5 列" })

-- 禁用 'J' 键的默认行为 (substitute character)
keymap.set({ "n", "v" }, "s", "<Nop>", { silent = true, desc = "禁用 s (substitute/change)" })
keymap.set({ "n" }, "J", "<Nop>", { silent = true, desc = "禁用 J " })

keymap.set("n", "sh", "<Cmd>set nosplitright<CR><Cmd>vsplit<CR>", { silent = true, desc = "向左垂直分屏" })
keymap.set("n", "sl", "<Cmd>set splitright<CR><Cmd>vsplit<CR>", { silent = true, desc = "向右垂直分屏" })
keymap.set("n", "sj", "<Cmd>set splitbelow<CR><Cmd>split<CR>", { silent = true, desc = "向下水平分屏" })
keymap.set("n", "sk", "<Cmd>set nosplitbelow<CR><Cmd>split<CR>", { silent = true, desc = "向上水平分屏" })

keymap.set("n", "<Leader>d", "<C-w>l", { silent = true, desc = "聚焦右侧窗口" })
keymap.set("n", "<Leader>a", "<C-w>h", { silent = true, desc = "聚焦左侧窗口" })
keymap.set("n", "<Leader>w", "<C-w>k", { silent = true, desc = "聚焦上方窗口" })
keymap.set("n", "<Leader>s", "<C-w>j", { silent = true, desc = "聚焦下方窗口" })

-- 交换窗口顺序 (Vim 原生命令提示)
-- 向右/下交换窗口: Ctrl+W r / Ctrl+W x
-- 向左/上交换窗口: Ctrl+W R / Ctrl+W X

-- 使用方向键调整窗口大小
keymap.set("n", "<Up>", "<Cmd>resize +5<CR>", { silent = true, desc = "增加窗口高度 (+5)" })
keymap.set("n", "<Down>", "<Cmd>resize -5<CR>", { silent = true, desc = "减少窗口高度 (-5)" })
keymap.set("n", "<Left>", "<Cmd>vertical resize -5<CR>", { silent = true, desc = "减少窗口宽度 (-5)" })
keymap.set("n", "<Right>", "<Cmd>vertical resize +5<CR>", { silent = true, desc = "增加窗口宽度 (+5)" })

-- 标签页管理
keymap.set("n", "te", "<Cmd>tabedit<CR>", { desc = "在新标签页打开文件/空缓冲区" })
keymap.set("n", "th", "<Cmd>tabprevious<CR>", { silent = true, desc = "切换到上一个标签页" })
keymap.set("n", "tl", "<Cmd>tabnext<CR>", { silent = true, desc = "切换到下一个标签页" })
