return {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.*",
	config = function()
		require("window-picker").setup({
			-- Использовать большие всплывающие буквы по центру окон
			hint = "floating-big-letter",

			-- Какие буквы использовать для выбора (можешь поменять под свою раскладку)
			selection_chars = "FJDKSLA;CMRUEIWOQP",

			filter_rules = {
				-- Не предлагать выбрать окна с деревом файлов или терминалом
				bo = {
					filetype = { "NvimTree", "neo-tree", "notify", "toggleterm" },
					buftype = { "terminal" },
				},
			},
		})
	end,
}
