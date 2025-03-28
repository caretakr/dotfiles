--
-- Keymaps config
--

local keymap = require("vim.keymap")

keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
