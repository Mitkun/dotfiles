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

-- Khi ở Normal mode, nhấn Ctrl + Space sẽ mở ngay menu Auto Import / Code Action
vim.keymap.set("n", "<C-Space>", vim.lsp.buf.code_action, { desc = "LSP Code Action (Auto Import)" })

-- Dự phòng cho một số terminal gửi mã C-@ khi bấm Ctrl+Space
vim.keymap.set("n", "<C-@>", vim.lsp.buf.code_action, { desc = "LSP Code Action (Auto Import)" })
