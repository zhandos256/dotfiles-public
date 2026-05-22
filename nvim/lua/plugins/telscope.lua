return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.55,
					},
				},
				-- ИГНОРИРОВАНИЕ МУСОРА
				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
					"__pycache__/",
					"%.DS_Store",
					"Library/", -- Игнорим macOS Library
					"%.app/", -- Игнорим пакеты приложений macOS
				},
				preview = {
					treesitter = false,
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
					},
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
			pickers = {
				find_files = {
					hidden = true,
					-- Дополнительно: не искать внутри .git, даже если hidden = true
					no_ignore = false,
				},
			},
		})

		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
		map("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document Symbols" })
		map("n", "<leader>fw", builtin.grep_string, { desc = "Find Word" })
	end,
}
