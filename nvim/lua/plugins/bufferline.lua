return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    vim.opt.termguicolors = true
    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
    require("bufferline").setup({
      options = {
        mode = "tabs",
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = false,
        separator_style = { "", "" },
        indicator = {
          icon = "❯",
          style = "icon",
        },
        -- padding = 1,
      },
      highlights = {
        fill = {
          bg = "#fdf6e3",
        },
        -- Неактивные вкладки (сделал чуть ярче, чтобы были читаемы)
        background = {
          fg = "#839496", -- Solarized Base0
          bg = "#fdf6e3",
        },
        buffer_visible = {
          fg = "#839496",
          bg = "#fdf6e3",
        },
        -- Активная вкладка (золотистый Solarized Yellow)
        buffer_selected = {
          fg = "#b58900", -- Тот самый золотой
          bg = "#fdf6e3",
          bold = true,
          italic = false,
        },
        -- Настройки для вкладок (Tabs mode)
        tab = {
          fg = "#839496",
          bg = "#fdf6e3",
        },
        tab_selected = {
          fg = "#b58900",
          bg = "#fdf6e3",
          bold = true,
          undercurl = true, -- попробуй вместо underline
          sp = "#b58900",   -- цвет волны
        },
        -- Убираем лишние детали
        separator = { fg = "#fdf6e3", bg = "#fdf6e3" },
        separator_selected = { fg = "#fdf6e3", bg = "#fdf6e3" },

        -- Если ты используешь подчеркивание, сделаем его тоже золотым
        indicator_selected = {
          fg = "#b58900",
          bg = "#fdf6e3",
          sp = "#b58900",
        },

        modified = { fg = "#839496", bg = "#fdf6e3" },
        modified_selected = { fg = "#b58900", bg = "#fdf6e3" },
      },
    })
  end,
}
