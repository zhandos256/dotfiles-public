return {
	"windwp/nvim-autopairs",
	event = "InsertEnter", -- загружаем только когда начинаем печатать
	config = function()
		local autopairs = require("nvim-autopairs")
		autopairs.setup({
			check_ts = true, -- интегрируем с Treesitter
			ts_config = {
				lua = { "string" }, -- не добавлять пары в строках lua
				javascript = { "template_string" },
			},
			disable_filetype = { "TelescopePrompt" }, -- не мешать в поиске
		})
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
