vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opt = vim.opt

-- Номера строк
opt.number = true -- Обычные номера
opt.relativenumber = false -- Относительные (очень ускоряют прыжки j/k в Vim-стиле)

-- Интерфейс и скролл
opt.scrolloff = 8 -- Курсор не прилипает к краю
opt.mouse = "a" -- Мышь включена
opt.wrap = false -- Не переносить строки
opt.termguicolors = true -- Поддержка 24-битного цвета (нужно для Alacritty/iTerm2)

-- Поиск
opt.hlsearch = true -- Подсветка поиска
opt.incsearch = true -- Поиск во время ввода
opt.ignorecase = true -- Игнорировать регистр
opt.smartcase = true -- Учитывать регистр, если есть заглавная

-- Отступы (2 пробела, как ты любишь)
opt.expandtab = true -- Табы в пробелы
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.smartindent = true

-- Файлы и буферы
opt.swapfile = false -- Нет .swp файлам
opt.backup = false -- Нет бэкапам
opt.undofile = false -- Нет undo файлам (как ты и просил)
opt.hidden = true -- Менять буферы без сохранения
opt.updatetime = 300 -- Быстрый отклик LSP (диагностика, hover)

-- Буфер обмена (macOS integration)
-- Работает нативно в Neovim, pbcopy/pbpaste подхватятся автоматически
opt.clipboard = "unnamedplus"
