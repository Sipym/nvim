local keymap = vim.keymap -- 方便后续调用

-- 使用方向键调整窗口大小
keymap.set("n", "<Up>", "<Cmd>resize +5<CR>", { silent = true, desc = "增加窗口高度 (+5)" })
keymap.set("n", "<Down>", "<Cmd>resize -5<CR>", { silent = true, desc = "减少窗口高度 (-5)" })
keymap.set("n", "<Left>", "<Cmd>vertical resize -5<CR>", { silent = true, desc = "减少窗口宽度 (-5)" })
keymap.set("n", "<Right>", "<Cmd>vertical resize +5<CR>", { silent = true, desc = "增加窗口宽度 (+5)" })

-- 标签页管理
keymap.set("n", "te", "<Cmd>tabedit<CR>", { desc = "在新标签页打开文件/空缓冲区" })
keymap.set("n", "th", "<Cmd>tabprevious<CR>", { silent = true, desc = "切换到上一个标签页" })
keymap.set("n", "tl", "<Cmd>tabnext<CR>", { silent = true, desc = "切换到下一个标签页" })
