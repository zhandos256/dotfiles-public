return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			ui = {
				border = "rounded",
				code_action = "💡",
			},
			-- Настройки клавиш внутри окон Саги
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
			-- Принудительно ставим q на закрытие во всех типах окон
			finder = {
				keys = {
					jump_to = "p", -- Preview the symbol without closing finder
					edit = { "o", "<CR>" }, -- Open in current buffer
					vsplit = "v", -- Open in vertical split
					split = "s", -- Open in horizontal split
					tabe = "t", -- Open in new tab
					quit = "q", -- Your existing quit key
					scroll_down = "<C-f>", -- Scroll preview window
					scroll_up = "<C-b>", -- Scroll preview window
				},
			},
			definition = {
				keys = {
					quit = "q",
				},
			},
			diagnostic = {
				keys = {
					quit = "q",
				},
			},
			rename = {
				in_select = false,
				keys = {
					quit = "q",
				},
			},
			outline = {
				keys = {
					quit = "q",
				},
			},
			hover = {
				open_link = "gx",
				open_cmd = "!open",
			},
			symbol_in_winbar = { enable = true },
			lightbulb = { enable = false },
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sagarename",
			callback = function()
				-- Ждем 5мс, чтобы буфер успел инициализироваться, и прыгаем в конец
				vim.defer_fn(function()
					vim.cmd("normal! $")
					-- Если хотите сразу режим вставки, то:
					vim.cmd("startinsert!")
				end, 5)
			end,
		})

		local map = vim.keymap.set

		-- === БИНДЫ БЕЗ ЛИДЕРА ===
		map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
		map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Goto Definition" })
		map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
		map("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "LSP Finder" })
		map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover Doc" })

		-- === БИНДЫ С ЛИДЕРОМ ===
		map("n", "<leader>fq", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "File Diagnostics" })
		map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
		map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
		map("n", "<leader>lo", "<cmd>Lspsaga outline<CR>", { desc = "Outline" })

		-- Навигация по диагностике
		map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
		map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
	end,
}
