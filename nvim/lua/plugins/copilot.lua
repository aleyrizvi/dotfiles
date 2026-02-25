return {
  -- Copilot core
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false, -- Keep visible so Tab can accept it
          debounce = 75,
          keymap = {
            accept = false, -- Handled by custom Tab mapping
            accept_word = "<C-Right>",
            accept_line = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      })
    end,
  },

  -- CopilotChat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      "zbirenbaum/copilot.lua",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      debug = false,
      window = {
        layout = "vertical",
        width = 0.4,
        height = 1,
        relative = "editor",
        border = "rounded",
        row = 0,
        col = vim.o.columns, -- Position at far right
      },
      mappings = {
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)

      -- Custom toggle function to open on right
      vim.keymap.set({ "n", "v" }, "<leader>aa", function()
        local chat = require("CopilotChat")
        chat.toggle({
          window = {
            layout = "vertical",
            width = 0.4,
            relative = "editor",
          },
        })
        -- Move window to the right
        vim.cmd("wincmd L")
      end, { desc = "Toggle Copilot Chat (Right Side)" })
    end,
  },
}
