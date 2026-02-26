local keymap = vim.keymap

keymap.set("n", "<c-a>", "ggVG")

keymap.set({ "n", "x" }, "<leader>p", '"0p')

vim.keymap.set("i", "jk", "<Esc>")

keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>x", "<cmd>x<cr>")

keymap.set("n", "j", [[v:count?'j':'gj']], { noremap = true, expr = true })
keymap.set("n", "k", [[v:count?'k':'gk']], { noremap = true, expr = true })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true })

vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Last buffer" })
