return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "bottom", -- Поиск сверху, как в Raycast/VS Code
						preview_width = 0.5,
					},
				},
				-- ИГНОРИРОВАНИЕ МУСОРА (убрал лишнее для Python проекта)
				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
					"__pycache__/",
					"%.DS_Store",
					"%.venv/",
					"venv/",
					"%.idea/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
					},
				},
				-- Тонкие рамки для Solarized Light
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = false,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
				},
			},
		})

		-- Загрузка расширений
		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")

		-- ГОРЯЧИЕ КЛАВИШИ
		map("n", "<leader>ff", builtin.find_files, { desc = "Поиск файлов (Cmd+P)" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Поиск текста по проекту (Grep)" })
		map("n", "<leader>fw", builtin.grep_string, { desc = "Поиск слова под курсором" })
		map("n", "<leader>fb", builtin.buffers, { desc = "Открытые буферы" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Справка" })
		map("n", "<leader>fr", builtin.oldfiles, { desc = "Недавние файлы" })
	end,
}
