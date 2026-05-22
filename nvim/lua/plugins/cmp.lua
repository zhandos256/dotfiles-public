return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets", -- Сниппеты как в VS Code
    "onsails/lspkind.nvim",         -- Иконки в меню
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Загружаем сниппеты в стиле VS Code из friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      -- Твои настройки для 10x скорости
      performance = {
        debounce = 0,
        throttle = 0,
        fetching_timeout = 50,
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = "rounded",
        },
        documentation = {
          border = "rounded",
        },
      },
      -- Интеграция иконок lspkind
      formatting = {
        fields = { "kind", "abbr", "menu" }, -- Порядок: Иконка, Название, Источник
        format = function(entry, vim_item)
          -- 1. Генерируем иконку (без текста типа 'Snippet')
          local kind = require("lspkind").cmp_format({
            mode = "symbol", -- ТОЛЬКО иконка
            maxwidth = 50,
            ellipsis_char = "...",
          })(entry, vim_item)

          -- 2. Добавляем твои сокращения в правую колонку
          local menu_icon = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          }

          kind.menu = menu_icon[entry.source.name]

          return kind
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }),
    })

    -- Поиск (/)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- Командная строка (:)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },    -- подсказка путей
      }, {
        { name = "cmdline" }, -- подсказка самих команд nvim
      }),
    })
  end,
}
