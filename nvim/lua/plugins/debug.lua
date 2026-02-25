-- Debug Adapter Protocol (DAP) configuration
-- Provides debugging support for multiple languages

return {
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      
      -- Virtual text for debugging
      "theHamsta/nvim-dap-virtual-text",
      
      -- DAP installations via Mason
      "jay-babu/mason-nvim-dap.nvim",
      
      -- Language specific adapters
      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",
    },
    
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Setup DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })
      
      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      })
      
      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Setup Mason DAP
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "delve",    -- Go
          "debugpy",  -- Python
          "node2",    -- Node.js
        },
        handlers = {},
      })
      
      -- Language specific setups
      require("dap-python").setup("python") -- Uses system python by default
      require("dap-go").setup()
      
      -- Node.js configuration
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
      
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
      
      dap.configurations.typescript = dap.configurations.javascript
      
      -- Debug keymaps - all under <leader>d* group
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
      
      -- Keep F-key shortcuts for convenience during debugging sessions
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue (F5)" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over (F10)" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into (F11)" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out (F12)" })
    end,
  },
}