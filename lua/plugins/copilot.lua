return {
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
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
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
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })
      
      -- Custom Tab handler that prioritizes Copilot over snippets
      vim.keymap.set("i", "<Tab>", function()
        local copilot = require("copilot.suggestion")
        
        -- First check if Copilot has a visible suggestion
        if copilot.is_visible() then
          copilot.accept()
          return
        end
        
        -- Check if we're in an active snippet and can jump
        if vim.snippet and vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
          return
        end
        
        -- Fall back to regular Tab behavior
        return vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
      end, { expr = true, desc = "Accept Copilot or jump snippet or Tab" })

      -- Shift+Tab for going backwards in snippets
      vim.keymap.set("i", "<S-Tab>", function()
        if vim.snippet and vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          return vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
        end
      end, { expr = true, desc = "Jump backwards in snippet" })

      -- Alternative: Ctrl+J as backup for Copilot acceptance
      vim.keymap.set("i", "<C-j>", function()
        local copilot = require("copilot.suggestion")
        if copilot.is_visible() then
          copilot.accept()
        end
      end, { desc = "Accept Copilot suggestion" })
    end,
  },
}