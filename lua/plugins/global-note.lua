return {
  "backdround/global-note.nvim",
  -- 懒加载，用的比较少。
  keys = {
    {"<leader>n","global_note.toggle_note", desc = "Toggle global note"},
  },
  config = function()
    local global_note = require("global-note")
    vim.keymap.set("n", "<leader>n", global_note.toggle_note, {
      desc = "Toggle global note",
    })
  end
}
