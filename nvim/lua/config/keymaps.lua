local map = vim.keymap.set

-- Выделить весь текст в файле
map("n", "<leader>a", "ggVG", { noremap = true, silent = true, desc = "Select all" })
map("i", "<D-BS>", "<C-w>", { noremap = true })
map("n", "<Space>", ":noh<CR>", { silent = true })
map("i", "jk", "<Esc>", { silent = true })
map("n", ";", ":", { silent = true })
map("n", "Y", "%y")
map("n", "<leader>n", ":tabnew ")
map("n", "<leader>w", ":w<CR>", { silent = true })
map("n", "<leader>q", ":q<CR>", { silent = true })
map("n", "<leader>x", ":x<CR>", { silent = true })
map("n", "<leader>cn", [[:%s/\<<C-r><C-w>\>/]], { desc = "Search and replace word under cursor" })
