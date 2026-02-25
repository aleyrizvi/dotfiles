return {
  {
    "Mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "Mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "Mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "gopls",
          "rust_analyzer",
          "clangd",
          "bashls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = true,
        -- Handler for modern vim.lsp.config
        handlers = {
          function(server_name)
            -- Default handler - servers are now configured via vim.lsp.config
            -- Mason will install them, but configuration is in lsp.lua
          end,
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "Mason-org/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "stylua",
          "black",
          "isort", 
          "prettierd",
          "prettier",
          "shfmt",
          "goimports",
          "rustfmt",
          -- Linters
          "eslint_d",
          "pylint",
          "shellcheck",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },
}
