return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "lua_ls", "pyright", "bashls", "dockerls" },
      },
    },
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local servers = { "ts_ls", "lua_ls", "pyright", "bashls", "dockerls" }

    -- Настройка через новый API Neovim 0.11
    for _, server in ipairs(servers) do
      local config = {
        capabilities = capabilities,
      }

      -- Специфические настройки для Lua
      if server == "lua_ls" then
        config.settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              preloadFileSize = 10000,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        }
      end

      -- НОВЫЙ МЕТОД: Регистрация и включение
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

    -- ГОРЯЧИЕ КЛАВИШИ
    -- Используем LspAttach, чтобы бинды работали только там, где есть сервер
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf, silent = true }

        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Форматирование (удобно для Python/Lua)
        vim.keymap.set("n", "<leader>rr", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })
  end,
}
