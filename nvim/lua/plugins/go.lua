-- Go.nvim - Advanced Go development plugin
-- Provides comprehensive Go tooling, testing, and code generation

return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig", 
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Go tools configuration
      goimports = "gopls", -- Use gopls for imports (recommended)
      gofmt = "gofumpt", -- Use gofumpt for better formatting
      
      -- Test configuration
      test_runner = "go", -- Use go test
      run_in_floaterm = false, -- Use quickfix instead of floating terminal
      
      -- LSP configuration
      lsp_cfg = false, -- Don't override existing LSP config
      lsp_keymaps = true, -- Enable go.nvim keymaps
      lsp_codelens = true, -- Enable code lens
      
      -- Diagnostic configuration  
      lsp_diag_hdlr = true, -- Use go.nvim's diagnostic handler
      lsp_diag_underline = true,
      lsp_diag_virtual_text = { space = 0, prefix = "" },
      lsp_diag_signs = true,
      lsp_diag_update_in_insert = false,
      
      -- Inlay hints (requires Neovim 0.10+)
      lsp_inlay_hints = {
        enable = true,
        only_current_line = false,
        show_variable_name = true,
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true, 
        other_hints_prefix = "=> ",
      },
      
      -- DAP (Debug Adapter Protocol)
      dap_debug = true,
      dap_debug_gui = true,
      dap_debug_keymap = true,
      
      -- Build configuration
      build_tags = "integration",
      textobjects = true,
      
      -- Icons
      icons = { breakpoint = "🧘", currentpos = "🏃" },
      
      -- Verbose output for debugging
      verbose = false,
    },
    
    config = function(_, opts)
      require("go").setup(opts)
      
      -- Auto-format and auto-import on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
      
      -- Go code operations under <leader>c* (Code group)
      
      -- Struct tags management
      vim.keymap.set("n", "<leader>csj", "<cmd>GoAddTag json<cr>", { desc = "Code: Add json tags" })
      vim.keymap.set("n", "<leader>csy", "<cmd>GoAddTag yaml<cr>", { desc = "Code: Add yaml tags" })
      vim.keymap.set("n", "<leader>csr", "<cmd>GoRmTag<cr>", { desc = "Code: Remove tags" })
      
      -- Code generation
      vim.keymap.set("n", "<leader>cie", "<cmd>GoIfErr<cr>", { desc = "Code: Add if err" })
      vim.keymap.set("n", "<leader>cfs", "<cmd>GoFillStruct<cr>", { desc = "Code: Fill struct" })
      vim.keymap.set("n", "<leader>ccm", "<cmd>GoCmt<cr>", { desc = "Code: Generate comment" })
      vim.keymap.set("n", "<leader>cim", "<cmd>GoImpl<cr>", { desc = "Code: Implement interface" })
      
      -- Go testing - integrated with <leader>t* test group
      vim.keymap.set("n", "<leader>tg", "<cmd>GoTest<cr>", { desc = "Test: Go tests" })
      vim.keymap.set("n", "<leader>tF", "<cmd>GoTestFunc<cr>", { desc = "Test: Go function" })
      vim.keymap.set("n", "<leader>tc", "<cmd>GoCoverage<cr>", { desc = "Test: Go coverage" })
      vim.keymap.set("n", "<leader>tC", "<cmd>GoCoverage -t<cr>", { desc = "Test: Go coverage toggle" })
      
      -- Build and run under <leader>c* (Code operations)
      vim.keymap.set("n", "<leader>cb", "<cmd>GoBuild<cr>", { desc = "Code: Build Go" })
      vim.keymap.set("n", "<leader>cr", "<cmd>GoRun<cr>", { desc = "Code: Run Go" })
      
      -- Go debugging - integrated with <leader>d* debug group
      vim.keymap.set("n", "<leader>dg", "<cmd>GoDebug<cr>", { desc = "Debug: Go debug" })
      vim.keymap.set("n", "<leader>dT", "<cmd>GoDbgTest<cr>", { desc = "Debug: Go test" })
      vim.keymap.set("n", "<leader>dS", "<cmd>GoDbgStop<cr>", { desc = "Debug: Go stop" })
      
      -- Go modules under <leader>c* (Code operations)
      vim.keymap.set("n", "<leader>cmt", "<cmd>GoModTidy<cr>", { desc = "Code: Go mod tidy" })
      vim.keymap.set("n", "<leader>cmi", "<cmd>GoModInit<cr>", { desc = "Code: Go mod init" })
      
      -- Alternate between test and source files under <leader>c* (Code navigation)
      vim.keymap.set("n", "<leader>cat", "<cmd>GoAlt<cr>", { desc = "Code: Alternate test/source" })
      vim.keymap.set("n", "<leader>cav", "<cmd>GoAltV<cr>", { desc = "Code: Alt vertical split" })
      vim.keymap.set("n", "<leader>cas", "<cmd>GoAltS<cr>", { desc = "Code: Alt horizontal split" })
    end,
    
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- Install/update all binaries
  },
}
