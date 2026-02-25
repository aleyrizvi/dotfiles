-- Neotest configuration for running tests inside Neovim
-- Supports multiple testing frameworks and languages

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      
      -- Language/framework adapters
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-plenary",
    },
    
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
            runner = "pytest", -- or "unittest"
          }),
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-vitest")({
            -- Filter out files that are not test files
            filter_dir = function(name, rel_path, root)
              return name ~= "node_modules"
            end,
          }),
          require("neotest-plenary"),
        },
        
        -- Test discovery
        discovery = {
          concurrent = 1,
          enabled = true,
        },
        
        -- Test execution
        running = {
          concurrent = true,
        },
        
        -- Status signs
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
        
        -- Output configuration
        output = {
          enabled = true,
          open_on_run = "short",
        },
        
        -- Quickfix integration
        quickfix = {
          enabled = true,
          open = false,
        },
        
        -- Summary window
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t",
            watch = "w",
          },
        },
      })
      
      -- Test keymaps - all under <leader>t* group
      local neotest = require("neotest")
      
      vim.keymap.set("n", "<leader>tr", neotest.run.run, { desc = "Test: Run nearest" })
      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Test: Run current file" })
      vim.keymap.set("n", "<leader>ta", function()
        neotest.run.run(vim.fn.getcwd())
      end, { desc = "Test: Run all tests" })
      vim.keymap.set("n", "<leader>td", function()
        neotest.run.run({ strategy = "dap" })
      end, { desc = "Test: Debug nearest" })
      vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Test: Toggle summary" })
      vim.keymap.set("n", "<leader>to", neotest.output.open, { desc = "Test: Show output" })
      vim.keymap.set("n", "<leader>tO", neotest.output_panel.toggle, { desc = "Test: Toggle output panel" })
      vim.keymap.set("n", "<leader>tw", neotest.watch.toggle, { desc = "Test: Toggle watch mode" })
      vim.keymap.set("n", "<leader>tS", neotest.run.stop, { desc = "Test: Stop running tests" })
      vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "Test: Run last test" })
      
      -- Navigation
      vim.keymap.set("n", "[t", function()
        neotest.jump.prev({ status = "failed" })
      end, { desc = "Test: Previous failed" })
      vim.keymap.set("n", "]t", function()
        neotest.jump.next({ status = "failed" })
      end, { desc = "Test: Next failed" })
    end,
  },
}