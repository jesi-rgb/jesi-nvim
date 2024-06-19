-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>b", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>j", harpoon_mark.add_file, { desc = "Add file to Harpoons buffer" })
vim.keymap.set("n", "ga", harpoon_ui.nav_next)

vim.keymap.set("v", "y", "ygv<Esc>")
vim.keymap.set("n", "<leader>ef", "<CMD>Oil<CR>", { desc = "Go back to file explorer" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

local opts = { noremap = true, silent = true }
vim.keymap.set("v", "(", ":s/\\%V\\(.*\\)\\%V/(\\1)/<CR>", opts)
vim.keymap.set("v", "[", ":s/\\%V\\(.*\\)\\%V/[\\1]/<CR>", opts)
vim.keymap.set("v", "{", ":s/\\%V\\(.*\\)\\%V/{\\1}/<CR>", opts)

vim.keymap.set("n", "j", function()
  if vim.fn.line(".") == vim.fn.line("$") then
    return "<C-e>"
  end
  return "gj"
end, { expr = true })
