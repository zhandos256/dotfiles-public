" === ГЛОБАЛЬНЫЕ НАСТРОЙКИ ===
let mapleader=","
filetype plugin indent on

" === ИНТЕРФЕЙС И ВИЗУАЛ ===
syntax on
set background=dark

" Пробуем habamax, если нет - дефолт
silent! colorscheme habamax

set number          " Номера строк
set scrolloff=8     " Держим курсор ближе к центру при скролле
set mouse=a         " Мышь работает (иногда нужно для скролла логов)
set nowrap          " Перенос длинных строк (полезно для конфигов)
set noundofile      " No undo file

" === ПОИСК И ЗАМЕНА ===
set hlsearch        " Подсветка поиска
set incsearch       " Поиск по мере ввода
set ignorecase      " Игнорировать регистр
set smartcase       " ...пока не введешь заглавную

" === ОТСТУПЫ И ТАБЫ ===
set expandtab       " Табы в пробелы
set tabstop=2       " Размер таба
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent

" === ПОВЕДЕНИЕ И ФАЙЛЫ ===
set noswapfile      " Без лишних .swp файлов
set nobackup        " Без бэкапов
set clipboard=unnamed,unnamedplus " Буфер обмена с macOS (требует neovim/pbcopy)
set hidden          " Переключать буферы без сохранения
set updatetime=300  " Быстрее отклик (важно для LSP)

" === ГОРЯЧИЕ КЛАВИШИ ===
" Быстрый выход и вход
inoremap jk <Esc>
nnoremap ; :

" Очистка поиска через пробел
nnoremap <Space> :noh<CR>

" Работа с файлами
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :xa<CR>
nnoremap <leader>t :tabnew<Space>

" Рефакторинг (твой запрос)
" Замена слова под курсором (Весь файл)
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" Замена в выделенном блоке
vnoremap <leader>s :s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Копирование до конца строки (как в современном Neovim)
nnoremap Y y$

" Навигация по табам (т.к. ты любишь табы)
nnoremap <Tab> :tabprevious<CR>
nnoremap <S-Tab> :tabnext<CR>

" === АВТОКОМАНДЫ ===
" Подсветка при копировании для обычного Vim (vi)
augroup YankHighlight
    autocmd!
    " При каждом копировании вызываем нашу функцию
    autocmd TextYankPost * call YankHighlight()
augroup END

function! YankHighlight()
    " Создаем временную подсветку для области, которую только что скопировали
    " Используем стандартную группу IncSearch (или Visual)
    let l:m = matchadd('IncSearch', '\%'.line("'[").'l\%>'.col("'[").'c.*\%<'.col("']"). 'c')

    " Удаляем подсветку через 300 миллисекунд (можешь поставить 500)
    call timer_start(50, {-> matchdelete(l:m)})
endfunction

" Убираем лишние пробелы при сохранении (для чистоты кода)
autocmd BufWritePre * :%s/\s\+$//e

" Изменение формы курсора для разных режимов
if has("terminfo")
  " 1 или 2 — блок (Normal)
  " 5 или 6 — палочка (Insert)
  let &t_SI = "\e[6 q" " Режим вставки (Start Insert)
  let &t_EI = "\e[2 q" " Режим после выхода (End Insert)
  " Опционально: замена на подчеркивание для режима замены
  let &t_SR = "\e[4 q"
endif
