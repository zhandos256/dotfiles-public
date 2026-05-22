return {
  'numToStr/Comment.nvim',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    -- Обязательно настраиваем помощника перед Comment.nvim
    require('ts_context_commentstring').setup({
      enable_autocmd = false,
    })

    require('Comment').setup({
      -- Используем Treesitter для определения символа комментария (# для python, // для lua и т.д.)
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

      -- Ваши старые настройки (padding, mappings и т.д.)
      mappings = {
        basic = true,
        extra = true,
      },
    })

    -- Ваши маппинги для Ctrl + /
    vim.keymap.set('n', '<C-_>', '<Plug>(comment_toggle_linewise_current)', { remap = true })
    vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', { remap = true })
  end
}
