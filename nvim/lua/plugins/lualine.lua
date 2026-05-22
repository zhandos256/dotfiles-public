return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "solarized_light",
				-- Убираем все разделители для плоского и чистого вида
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
				disabled_filetypes = { statusline = { "NvimTree", "TelescopePrompt" } },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							-- Только первая буква режима, без иконок. Очень компактно.
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = {
					{ "branch", icon = "" }, -- Убрали иконку ветки
					{
						"diagnostics",
						symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
						colored = false, -- Весь статусбар в одном тоне
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = { modified = "*", readonly = "RO", unnamed = "" },
					},
				},
				lualine_x = {
					-- Убрали кодировку и лишнее, оставили только тип файла текстом
					{ "filetype", icon_only = false },
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					"location",
				},
			},
			inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			},
		})
	end,
}
