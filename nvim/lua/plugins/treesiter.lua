return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Отключаем встроенные маппинги плагинов Neovim (ftplugin),
      -- чтобы они не конфликтовали с нашими текстовыми объектами.
      vim.g.no_plugin_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          enable = true,
          -- Автоматически прыгать вперед к тексту, если курсор не на нем (как в targets.vim)
          lookahead = true,

          -- Настройка режима выделения (по умолчанию 'v' - посимвольно)
          selection_modes = {
            ["@parameter.outer"] = "v", -- параметры выделяем посимвольно
            ["@function.outer"] = "V",  -- функции выделяем ПОСТРОЧНО (чтобы не терять скобки)
            ["@class.outer"] = "V",     -- классы тоже построчно
          },

          -- Включать ли окружающие пробелы (false — выделять строго код)
          include_surrounding_whitespace = false,
        },
      })

      -- ГОРЯЧИЕ КЛАВИШИ (Text Objects)
      -- Режимы 'x' (Visual) и 'o' (Operator pending, например после нажатия 'd' или 'y')
      --
      -- Работа с вызовами функций (FastAPI(), print() и т.д.)
      vim.keymap.set({ "x", "o" }, "aa", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
      end, { desc = "Выделить весь вызов функции" })

      vim.keymap.set({ "x", "o" }, "ia", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
      end, { desc = "Выделить аргументы внутри вызова" })

      -- Работа с функциями (m - от слова Method/Function)
      vim.keymap.set({ "x", "o" }, "am", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
      end, { desc = "Выделить всю функцию (снаружи)" })

      vim.keymap.set({ "x", "o" }, "im", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
      end, { desc = "Выделить тело функции (внутри)" })

      -- Работа с классами (c - Class)
      vim.keymap.set({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
      end, { desc = "Выделить весь класс" })

      vim.keymap.set({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
      end, { desc = "Выделить содержимое класса" })

      -- Работа с областью видимости (s - Scope)
      vim.keymap.set({ "x", "o" }, "as", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
      end, { desc = "Выделить текущую область видимости (scope)" })
    end,
  },

  -- Основной плагин Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter")

      configs.setup({
        -- Список языков для автоматической установки
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "python",
          "zsh",
          "bash",
          "dockerfile",
          "yaml",
          "json",
          "c",
        },

        -- Автоустановка отсутствующих парсеров при открытии файла
        auto_install = true,

        -- Улучшенная подсветка синтаксиса
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Умные отступы на основе AST дерева
        indent = { enable = true },

        -- Умное пошаговое выделение (Incremental Selection)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>ss",    -- Начать выделение (start)
            node_incremental = "<leader>si",  -- Расширить до следующего узла кода (increment)
            scope_incremental = "<leader>sc", -- Расширить до области видимости (scope)
            node_decremental = "<leader>sd",  -- Уменьшить область выделения (decrement)
          },
        },
      })
    end,
  },
}
