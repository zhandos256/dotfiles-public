return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<C-k>", -- Меняем на C-f (Forward), чтобы не конфликтовать с Tab в nvim-cmp
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			ignore_filetypes = {
				cpp = true,
				-- Текстовые и тяжелые форматы
				log = true,
				txt = true,
				csv = true,
				markdown = true, -- если не нужна помощь в текстах
				-- Файлы сборки и зависимостей
				json = true, -- пакетные менеджеры часто генерят гигантские json
				sql = true, -- дампы баз данных могут "съесть" все ресурсы
				-- Специфические расширения
				env = true, -- переменные окружения (безопасность)
				xml = true,
			},
			color = {
				suggestion_color = "#93A1A1", -- Серый цвет приятнее для глаз, чем чисто белый
				cterm = 244,
			},
			log_level = "off", -- Для 10x продуктивности логи не нужны, лишний I/O
			disable_inline_completion = false,
			disable_keymaps = false,
		})
	end,
}
