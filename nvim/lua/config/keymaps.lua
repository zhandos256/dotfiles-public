local map = vim.keymap.set

-- Выделить весь текст в файле
map("n", "<leader>gt", ":lua GoTo()<CR>", { noremap = true })
map("n", "vv", "viw", { desc = "Выделить слово под курсором" })
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

map("n", ",w", function()
	-- 1. Вызываем плагин, он просит выбрать окно и возвращает его ID
	local picked_window_id = require("window-picker").pick_window()

	-- 2. Если окно успешно выбрано (пользователь не нажал Esc), переключаем на него фокус
	if picked_window_id then
		vim.api.nvim_set_current_win(picked_window_id)
	end
end, { desc = "Выбрать окно для перехода" })
