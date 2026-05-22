local function clean_sidebar()
	-- Делаем колонку знаков (ошибки, гит, LSP) полностью прозрачной
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

	-- Убираем фон у самих значков ошибок и предупреждений
	vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = "NONE", fg = "#dc322f" })
	vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = "NONE", fg = "#b58900" })
	vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = "NONE", fg = "#268bd2" })
	vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = "NONE", fg = "#2aa198" })

	-- Если используешь Gitsigns, убираем фон и у них
	vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "NONE", fg = "#859900" })
	vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "NONE", fg = "#b58900" })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "NONE", fg = "#dc322f" })
end

-- Запуск
clean_sidebar()

-- Чтобы настройки не слетели при смене темы
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = clean_sidebar,
})

local function fix_colors()
	-- БЫЛО: #93a1a1 (светло-серый)
	-- СТАЛО: #657b83 (глубокий серый, base00) — это сделает цифры четче
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#657b83", bg = "NONE" })

	-- Текущий номер строки (активный)
	-- Сделаем его Base01 (#586e75), чтобы он выделялся на фоне остальных
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#586e75", bg = "NONE", bold = true })

	-- Остальные фиксы оставляем
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
end

-- Не забудь, что эта функция должна вызываться ПОСЛЕ colorscheme
fix_colors()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = fix_colors,
})
