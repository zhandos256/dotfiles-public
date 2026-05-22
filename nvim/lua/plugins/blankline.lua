return {
	-- 1. Основа: Статические линии
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			-- Используем максимально тусклый цвет (Base3 или Base2)
			vim.api.nvim_set_hl(0, "IblIndent", { fg = "#eee8d5" })

			require("ibl").setup({
				indent = {
					char = "╎",
					highlight = "IblIndent",
				},
				scope = { enabled = false },
				exclude = {
					filetypes = { "help", "neo-tree", "lazy", "mason", "notify" },
				},
			})
		end,
	},

	-- 2. Активный блок: Делаем его "мягче"
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			-- СТАЛО: Используем обычную тонкую линию вместо жирной ┃
			symbol = "│",
			options = {
				try_as_border = true,
			},
			draw = {
				delay = 0,
				animation = function(s, n)
					return 0
				end,
			},
		},
		config = function(_, opts)
			-- СТАЛО: Вместо яркого синего используем мягкий серый (Base01 #93a1a1)
			-- Убрали bold: true, чтобы линия не выпирала
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#93a1a1" })
			require("mini.indentscope").setup(opts)
		end,
	},
}
