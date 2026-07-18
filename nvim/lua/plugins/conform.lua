return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- запускается прямо перед сохранением файла
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Быстрое форматирование вручную по leader f
			"<leader>rr",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_organize_imports", "ruff_format" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			bash = { "shfmt" },
		},
		-- Автоформатирование при сохранении (Format on save)
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true, -- если нет форматера, использовать LSP
		},
		-- Настройки конкретных форматеров
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" }, -- отступ 2 пробела для bash
			},
		},
	},
}
