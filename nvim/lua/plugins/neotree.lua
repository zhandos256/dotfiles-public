return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "antosha417/nvim-lsp-file-operations",
  },
  init = function()
    -- Выключаем стандартный netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- ФИКС ТЕКСТА В ИНПУТЕ (для Solarized Light)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree-popup",
      callback = function()
        vim.api.nvim_set_hl(0, "NuiInputNormal", { fg = "#586e75", bg = "#eee8d5" })
      end,
    })

    -- Биндим <leader>e на toggle в режиме float
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle float<CR>", { silent = true })
  end,
  opts = {
    close_if_last_window = true,
    window = {
      position = "float",
      width = 60,         -- Увеличил ширину, чтобы влезли длинные имена файлов
      popup_strategy = "FP",
      border = "rounded", -- Основная граница окна
      popup = {
        -- ИСПРАВЛЕНО: Теперь здесь строка вместо таблицы, что убирает ошибку
        border = "rounded",
        position = "50%",
      },
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = "none",
        ["e"] = "close_window",
        ["q"] = "close_window",
      },
    },
    filesystem = {
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- Добавляет воздух слева от иконок
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = " ",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added = "✚",
          modified = "",
          deleted = "✖",
          renamed = "󰁯",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
  },
}
